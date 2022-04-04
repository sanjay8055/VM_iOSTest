//
//  RoomsViewModel.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype modelType
    func fetchList(endPoint: String ,_ completionHandler: @escaping(Result<Bool, Error>) -> Void)
    func parseJsonResponse(_ data: Data) throws -> [modelType]
}

class RoomsViewModel: ViewModelProtocol {
    
    typealias modelType = Room
    var roomsList:[Room] = []
    var networkManager:NetworkOperationsProtocol
    
    init(networkManager: NetworkOperationsProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchList(endPoint: String, _ completionHandler: @escaping(Result<Bool, Error>) -> Void){
        networkManager.makeRequest(Constants.APIBaseUrl + endPoint) { data, error in
            if let data = data {
                do {
                    let roomsList = try self.parseJsonResponse(data)
                    self.roomsList.append(contentsOf: roomsList)
                    completionHandler(.success(true))
                } catch {
                    completionHandler(.failure(error))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
    }
    
    func parseJsonResponse(_ data: Data) throws -> [modelType] {
      do {
        let roomsList = try JSONDecoder().decode([modelType].self, from: data)
          return roomsList
      } catch {
        debugPrint(error.localizedDescription)
        throw NetworkErrors.invalidResponse
      }
    }
}
