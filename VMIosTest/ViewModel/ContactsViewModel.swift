//
//  ContactsViewModel.swift
//  VMIosTest
//
//  Created by Sanjay Raskar on 29/03/22.
//

import Foundation

class ContactsViewModel: ViewModelProtocol {
    
    typealias modelType = Contact
    var contactsList:[Contact] = []
    var networkManager = NetworkManager.shared
    var filteredContactsList:[Contact] = []

    func fetchList(endPoint: String, _ completionHandler: @escaping(Result<Bool, Error>) -> Void){
        networkManager.makeRequest(Constants.APIBaseUrl + endPoint) { data, error in
            if let data = data {
                do {
                    let contactList = try self.parseJsonResponse(data)
                    self.contactsList.append(contentsOf: contactList)
                    completionHandler(.success(true))
                } catch {
                    completionHandler(.failure(error))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.failure(NetworkErrors.unknownError))
            }
        }
    }
    
    func parseJsonResponse(_ data: Data) throws -> [modelType] {
      do {
        let contactList = try JSONDecoder().decode([modelType].self, from: data)
          return contactList
      } catch {
        debugPrint(error.localizedDescription)
        throw NetworkErrors.invalidResponse
      }
    }
    
    func filterSearchresult(searchText: String, completion: (Bool) -> ()) {
        filteredContactsList.removeAll()
        let array = contactsList.filter({$0.firstName.localizedCaseInsensitiveContains(searchText) || $0.lastName.localizedCaseInsensitiveContains(searchText)})
        filteredContactsList = array
        completion(true)
    }
}
