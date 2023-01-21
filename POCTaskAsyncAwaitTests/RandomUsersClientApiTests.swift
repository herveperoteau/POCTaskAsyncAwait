//
//  RandomUsersClientApiTests.swift
//  POCTaskAsyncAwaitTests
//
//  Created by Herve Peroteau on 21/01/2023.
//

import XCTest

@testable import POCTaskAsyncAwait

final class RandomUsersClientApiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchUsers() async throws {
       let clientApi = RandomUsersClientApi()
       let users = try await clientApi.fetchUsers(count: 5)
       print("users: \(users)")
       XCTAssertTrue(users.count == 5)
    }
}
