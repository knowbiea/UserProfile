//
//  NetworkServiceTests.swift
//  UserProfileTests
//
//  Created by Arvind on 31/05/24.
//

import XCTest
@testable import UserProfile

final class NetworkServiceTests: XCTestCase {
    
    static let mockURL = "http://mock.test.com"
    
    private struct EndpointMock: Requestable {
        var path: String
        var isFullPath: Bool = false
        var method: HTTPMethodType
        var headerParameters: [String: String] = [:]
        var queryParametersEncodable: Encodable?
        var queryParameters: [String: Any] = [:]
        var bodyParametersEncodable: Encodable?
        var bodyParameters: [String: Any] = [:]
        
        init(path: String, method: HTTPMethodType) {
            self.path = path
            self.method = method
        }
    }
    
    final class NetworkErrorLoggerMock: NetworkErrorLogger {
        var loggedErrors: [Error] = []
        func log(request: URLRequest) { }
        func log(responseData data: Data?, response: URLResponse?) { }
        func log(error: Error) {
            loggedErrors.append(error)
        }
    }
    
    private enum NetworkErrorMock: Error {
        case someError
    }
    
    func testNetworkService_checkingResponseIsSuccessfulAsync() async {
        // given
        let config = NetworkConfigurableMock()
        var responseResultData: Data = Data()
        var statusCode = 0
        
        let endpoint = EndpointMock(path: "/user", method: .get)
        let expectedResponseData = "This is a Sample Data".data(using: .utf8) ?? Data()
        let urlResponse = HTTPURLResponse(url: config.baseURL, statusCode: 200, httpVersion: "1.1", headerFields: [:])
        let mockNetworkSessionManager = NetworkSessionManagerMock(response: urlResponse,
                                                                  data: expectedResponseData,
                                                                  error: nil)
        let networkService = DefaultNetworkService(config: config,
                                                   sessionManager: mockNetworkSessionManager)
        
        
        // when
        do {
            let (data, response) = try await networkService.request(endpoint)
            responseResultData = data
            statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
        } catch {
            XCTFail("Error is nil and This should not happen")
            
        }
        
        // then
        XCTAssertEqual(responseResultData, expectedResponseData)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testNetworkService_checkingResponseIsNetworkCancelledAsync() async {
        // given
        var completionCallsCount = 0
        let config = NetworkConfigurableMock()
        let cancelledError = NSError(domain: "com.sample.user.network", code: NSURLErrorCancelled)
        
        let endpoint = EndpointMock(path: "/user", method: .get)
        let mockNetworkSessionManager = NetworkSessionManagerMock(response: nil,
                                                                  data: nil,
                                                                  error: cancelledError as Error)
        let networkService = DefaultNetworkService(config: config,
                                                   sessionManager: mockNetworkSessionManager)
        
        // when
        do {
            let (data, response) = try await networkService.request(endpoint)
            
        } catch {
            completionCallsCount += 1
        }
        
        // then
        XCTAssertEqual(completionCallsCount, 1)
    }
    
    func testNetworkService_whenStatusCodeEqualOrAbove400Async() async {
        // given
        let config = NetworkConfigurableMock()
        var completionCallsCount = 0
        
        let endpoint = EndpointMock(path: "/user", method: .get)
        let urlResponse = HTTPURLResponse(url: config.baseURL, statusCode: 500, httpVersion: "1.1", headerFields: [:])
        let mockNetworkSessionManager = NetworkSessionManagerMock(response: urlResponse,
                                                                  data: nil,
                                                                  error: NetworkErrorMock.someError)
        let networkService = DefaultNetworkService(config: config,
                                                   sessionManager: mockNetworkSessionManager)
        
        // when
        do {
            let (_, _) = try await networkService.request(endpoint)
            XCTFail("Result is empty and This should not happen")
            
        } catch {
            if case NetworkError.generic(let code) = error {
                completionCallsCount += 1
            }
        }
        
        // then
        XCTAssertEqual(completionCallsCount, 1)
    }
    
    func testNetworkService_checkingResponseIsNetworkConnected() async {
        // given
        let config = NetworkConfigurableMock()
        let error = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        var completionCallsCount = 0
        
        let networkErrorLogger = NetworkErrorLoggerMock()
        let endpoint = EndpointMock(path: "/user", method: .get)
        let mockNetworkSessionManager = NetworkSessionManagerMock(response: nil,
                                                                  data: nil,
                                                                  error: error as Error)
        let networkService = DefaultNetworkService(config: config,
                                                   sessionManager: mockNetworkSessionManager,
                                                   logger: networkErrorLogger)
        
        // when
        do {
            let (_, _) = try await networkService.request(endpoint)
            XCTFail("Result is empty and This should not happen")
            
        } catch {
            guard case NetworkError.notConnected = error else {
                XCTFail("NetworkError Cancelled not found")
                return
            }
            
            completionCallsCount += 1
        }
        
        // then
        XCTAssertEqual(completionCallsCount, 1)
        XCTAssertTrue(networkErrorLogger.loggedErrors.contains {
            guard case NetworkError.notConnected = $0 else { return false }
            return true
        })
    }
}
