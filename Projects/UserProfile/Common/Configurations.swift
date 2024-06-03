//
//  Configurations.swift
//  UserProfile
//
//  Created by Arvind on 03/06/24.
//

import Foundation

struct Configuration {
    
    enum Environment: String {
        case staging = "staging"
        case production = "production"
        
        var baseURL: URL {
            switch self {
            case .staging: return URL(string: url).value
            case .production: return URL(string: url).value
            }
        }
        
        var url: String {
            switch self {
            case .staging: return "https://dummyjson.com/" 
            case .production: return "https://dummyjson.com/"
            }
        }
    }
    
    static var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            print("Configuration: \(configuration)")
            
            if configuration.contains("Development") {
                return Environment.staging
            }
        }
        
        return Environment.production
    }()
}
