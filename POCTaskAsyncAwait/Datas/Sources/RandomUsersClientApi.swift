//
//  RandomUsersClientApi.swift
//  POCTaskAsyncAwait
//
//  Created by Herve Peroteau on 21/01/2023.
//

import Foundation
import RxSwift

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
    
    
    func fetchUsersRx(count: Int = 25) -> Single<[User]> {
        
        Single.create { singleObserver in
            
            let url = Consts.baseUrl
                .appending(path: "api")
                .appending(queryItems: [
                    URLQueryItem(name: "results", value: "\(count)")
                ])
            
            let urlRequest = URLRequest(url: url)
            
            let task = session.dataTask(with: urlRequest) { data, response, error in
                
                if let error {
                    singleObserver(.failure(error))
                    return
                }
                
                guard let data else {
                    singleObserver(.failure(NSError(domain: "no_data", code: 007)))
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(FetchUserResult.self, from: data)
                    singleObserver(.success(result.users))
                }
                catch {
                    singleObserver(.failure(error))
                }
            }
            
            task.resume()
            
            return Disposables.create(with: task.cancel)
        }
    }
}
