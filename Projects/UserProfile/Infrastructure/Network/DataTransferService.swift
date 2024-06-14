//
//  DataTransferService.swift
//  UserProfile
//
//  Created by Arvind on 31/05/24.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol DataTransferService {
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E) async throws -> T where T == E.Response
}

final class DefaultDataTransferService {
    
    // MARK: - Properties
    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolver
    private let errorLogger: DataTransferErrorLogger
    
    // MARK: - Dependency Inversion Principles
    init(networkService: NetworkService,
        errorResolver: DataTransferErrorResolver = DefaultDataTransferErrorResolver(),
        errorLogger: DataTransferErrorLogger = DefaultDataTransferErrorLogger()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
}

extension DefaultDataTransferService: DataTransferService {
    func request<T, E>(with endpoint: E) async throws -> T where T: Decodable, T == E.Response, E: ResponseRequestable {
        do {
            let (data, _) = try await networkService.request(endpoint)
            return try await decode(data: data, decoder: endpoint.responseDecoder)
            
        } catch {
            self.errorLogger.log(error: error)
            guard let error = error as? NetworkError else { throw error }
            throw self.resolve(networkError: error)
            
        }
    }
    
    // MARK: - Private Methods
    private func decode<T: Decodable>(data: Data?,
                                      decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }
    
    private func decode<T: Decodable>(data: Data?,
                                      decoder: ResponseDecoder) async throws -> T {
        do {
            guard let data = data else { throw DataTransferError.noResponse }
            return try decoder.decode(data)
            
        } catch {
            self.errorLogger.log(error: error)
            throw DataTransferError.parsing(error)
            
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}

// MARK: - Transfer Error Resolver
protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

final class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error {
     return error
    }
}

// MARK: - DataTransfer Error Logger
protocol DataTransferErrorLogger {
    func log(error: Error)
}

final class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
    func log(error: Error) {
        DLog("Error Logger: \(error)")
    }
}

// MARK: - Response Decoders
protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

final class JsonResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init(){ }
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
