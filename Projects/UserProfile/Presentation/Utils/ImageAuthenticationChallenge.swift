//
//  ImageDownloadAuthenticationChallenge.swift
//  UserProfile
//
//  Created by Arvind on 05/06/24.
//

import Foundation
import Kingfisher

final class ImageAuthenticationChallenge: AuthenticationChallengeResponsible {
    
    func downloader(_ downloader: ImageDownloader, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                let credential = URLCredential(trust: serverTrust)
                completionHandler(.useCredential, credential)
                return
            }
        }
        completionHandler(.performDefaultHandling, nil)
    }
}
