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
    
    func testNetworkService_checkingResponseIsSuccessful() {
        // given
        let config = NetworkConfigurableMock()
        var responseResultData: Data = Data()
        var completionCallsCount = 0
        
        let expectedResponseData = "This is a Sample Data".data(using: .utf8) ?? Data()
        let networkService = DefaultNetworkService(config: config,
                                                   sessionManager: NetworkSessionManagerMock(response: nil,
                                                                                             data: expectedResponseData,
                                                                                             error: nil))
        
        // when
        _ = networkService.request(endpoint: EndpointMock(path: NetworkServiceTests.mockURL, method: .get)) { result in
            guard let responseData = try? result.get() else {
                XCTFail("Should return proper response")
                return
            }
            
            responseResultData = responseData
            completionCallsCount += 1
        }
        
        // then
        XCTAssertEqual(responseResultData, expectedResponseData)
        XCTAssertEqual(completionCallsCount, 1)
    }
    
    func testNetworkService_checkingResponseIsNetworkCancelled() {
        // given
        let config = NetworkConfigurableMock()
        let cancelledError = NSError(domain: "com.sample.user.network", code: NSURLErrorCancelled)
        var completionCallsCount = 0
        
        let networkService = DefaultNetworkService(config: config,
                                                   sessionManager: NetworkSessionManagerMock(response: nil,
                                                                                             data: nil,
                                                                                             error: cancelledError as Error))
        
        // when
        _ = networkService.request(endpoint: EndpointMock(path: NetworkServiceTests.mockURL, method: .get), completion: { result in
            do {
                _ = try result.get()
                XCTFail("Result is empty and This should not happen")
                
            } catch {
                guard case NetworkError.cancelled = error else {
                    XCTFail("NetworkError Cancelled not found")
                    return
                }
                
                completionCallsCount += 1
            }
        })
        
        // then
        XCTAssertEqual(completionCallsCount, 1)
    }
    
    func testNetworkService_whenStatusCodeEqualOrAbove400() {
        // given
        let config = NetworkConfigurableMock()
        var completionCallsCount = 0
        var statusCode = 0
        
        let response = HTTPURLResponse(url: URL(string: "https://www.sample.com")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: [:])
        let networkService = DefaultNetworkService(config: config,
                                                   sessionManager: NetworkSessionManagerMock(response: response,
                                                                                             data: nil,
                                                                                             error: NetworkErrorMock.someError))
        
        // when
        _ = networkService.request(endpoint: EndpointMock(path: NetworkServiceTests.mockURL, method: .get), completion: { result in
            do {
                _ = try result.get()
                XCTFail("Result is empty and This should not happen")
                
            } catch {
                if case NetworkError.error(let code, _) = error {
                    statusCode = code
                    completionCallsCount += 1
                }
            }
        })
        
        // then
        XCTAssertEqual(completionCallsCount, 1)
        XCTAssertEqual(statusCode, 500)
    }
    
    func testNetworkService_checkingResponseIsNetworkConnected() {
        // given
        let config = NetworkConfigurableMock()
        let error = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        var completionCallsCount = 0
        
        let networkErrorLogger = NetworkErrorLoggerMock()
        let networkService = DefaultNetworkService(config: config,
                                                   sessionManager: NetworkSessionManagerMock(response: nil,
                                                                                             data: nil,
                                                                                             error: error as Error),
                                                   logger: networkErrorLogger)
        
        // when
        _ = networkService.request(endpoint: EndpointMock(path: NetworkServiceTests.mockURL, method: .get), completion: { result in
            do {
                _ = try result.get()
                XCTFail("Result is empty and This should not happen")
                
            } catch {
                guard case NetworkError.notConnected = error else {
                    XCTFail("NetworkError Cancelled not found")
                    return
                }
                
                completionCallsCount += 1
            }
        })
        
        // then
        XCTAssertEqual(completionCallsCount, 1)
        XCTAssertTrue(networkErrorLogger.loggedErrors.contains {
            guard case NetworkError.notConnected = $0 else { return false }
            return true
        })
    }
}
