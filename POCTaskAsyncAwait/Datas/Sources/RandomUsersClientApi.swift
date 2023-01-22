//
//  RandomUsersClientApi.swift
//  POCTaskAsyncAwait
//
//  Created by Herve Peroteau on 21/01/2023.
//

import Foundation

struct FetchUserResult: Codable {
   let users: [User]

   enum CodingKeys: String, CodingKey {
      case users = "results"
   }
}

struct RandomUsersClientApi {

   private struct Consts {
      static let baseUrl = URL(string: "https://randomuser.me")!
   }

   private let session = URLSession.shared

   /// Fetch users randomly
   /// - Parameter count: count of users to fetch
   /// - Returns: an array of User
   func fetchUsers(count: Int = 25) async throws -> [User] {
      // https://randomuser.me/api/?results=25
      let url = Consts.baseUrl
         .appending(path: "api")
         .appending(queryItems: [
            URLQueryItem(name: "results", value: "\(count)")
         ])

      let (data, _) = try await session.data(from: url)
      let decoder = JSONDecoder()
      let result = try decoder.decode(FetchUserResult.self, from: data)
      return result.users
   }
}
