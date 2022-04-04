//
//  NetworkManager.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import Foundation
import UIKit

enum NetworkErrors: Error {
  case invalidURL
  case invalidResponse
  case unknownError
}

protocol NetworkOperationsProtocol {
    func makeRequest(_ url: String, completionHandler: @escaping(_ data: Data?, _ error: Error?) -> Void)
}

final class NetworkManager: NetworkOperationsProtocol {
    static let shared = NetworkManager()
    
    private init() {
        debugPrint("Network manager initialized")
    }
    
    //Get request
    func makeRequest(_ url: String, completionHandler: @escaping(_ data: Data?, _ error: Error?) -> Void) {
        if !Reachability.isConnectedToNetwork(){
            print("Internet Connection not Available!")
            showAlertWithCompletion(message: "No Internet Available", okTitle: "OK", cancelTitle: nil) { okPressed in
                
            }
            return
        }
        
        guard let url = URL(string: url) else {
            completionHandler(nil, NetworkErrors.invalidURL)
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                completionHandler(data, nil)
            } else if let error = error {
                completionHandler(nil, error)
            }
        }.resume()
    }
}
