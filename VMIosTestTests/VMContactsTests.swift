//
//  VMIosTestTests.swift
//  VMIosTestTests
//
//  Created by Sanjay Raskar on 29/03/22.
//

import XCTest
@testable import VMIosTest

class VMContactsTests: XCTestCase {

    var sut = ContactsViewModel(networkManager: MockNetworkManager())
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testgetContacts() throws {
        sut.networkManager = MockNetworkManager()
        let expectation = expectation(description: "fetch contacts")
        sut.fetchList(endPoint: Constants.contactsUrlEndPoint, { result in
            switch result {
            case .success:
                XCTAssertTrue(self.sut.contactsList.count > 0)
            case .failure(let error):
                XCTAssertTrue(self.sut.contactsList.count == 0, error.localizedDescription)
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 3.0, handler: nil)
        
    }
    
    func testgetContactsFailure() throws {
        
        //let expectation = expectation(description: "fetch contacts")
        sut.fetchList(endPoint: "test", { result in
            switch result {
            case .success:
                XCTAssertTrue(self.sut.contactsList.count > 0)
            case .failure(let error):
                XCTAssertTrue(self.sut.contactsList.count == 0, error.localizedDescription)
            }
            //expectation.fulfill()
        })
        //waitForExpectations(timeout: 2.0, handler: nil)
        
    }

    func testFilterResult() throws {
        sut.filterSearchresult(searchText: "sa") { result in
            XCTAssertTrue(self.sut.filteredContactsList.count == 0)
        }
    }
    
    func testParseResponse() {
        do {
        _ = try sut.parseJsonResponse("{}/".data(using: .utf8)!)
        } catch {
            XCTAssertTrue((error as? NetworkErrors) == NetworkErrors.invalidResponse)
        }
    }

}


class MockNetworkManager: NetworkOperationsProtocol {
    func makeRequest(_ url: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(nil,nil)
    }
    
}
