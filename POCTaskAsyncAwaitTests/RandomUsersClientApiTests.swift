//
//  RandomUsersClientApiTests.swift
//  POCTaskAsyncAwaitTests
//
//  Created by Herve Peroteau on 21/01/2023.
//

import XCTest

@testable import POCTaskAsyncAwait

final class RandomUsersClientApiTests: XCTestCase {

   // Very easy to test async function
   // No need to use expectation ...
   // Just put async in the function signature
   func testFetchUsers() async throws {
      let clientApi = RandomUsersClientApi()
      let users = try await clientApi.fetchUsers(count: 5)
      print("users: \(users)")
      XCTAssertTrue(users.count == 5)
   }
}
