//
//  VMRoomsTests.swift
//  VMIosTestTests
//
//  Created by Sanjay Raskar on 30/03/22.
//

import XCTest
@testable import VMIosTest

class VMRoomsTests: XCTestCase {

    var sut = RoomsViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testgetRooms() throws {
        
        let expectation = expectation(description: "fetch Rooms")
        sut.fetchList(endPoint: Constants.roomsUrlEndPoint, { result in
            switch result {
            case .success:
                XCTAssertTrue(self.sut.roomsList.count > 0)
            case .failure(let error):
                XCTAssertTrue(self.sut.roomsList.count == 0, error.localizedDescription)
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2.0, handler: nil)
        
    }
    
    func testgetContactsFailure() throws {
        
        let expectation = expectation(description: "fetch Rooms")
        sut.fetchList(endPoint: "test", { result in
            switch result {
            case .success:
                XCTAssertTrue(self.sut.roomsList.count > 0)
            case .failure(let error):
                XCTAssertTrue(self.sut.roomsList.count == 0, error.localizedDescription)
            }
            expectation.fulfill()
        })
        waitForExpectations(timeout: 2.0, handler: nil)
        
    }


}
