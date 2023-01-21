//
//  User.swift
//  POCTaskAsyncAwait
//
//  Created by Herve Peroteau on 21/01/2023.
//

import Foundation

struct User: Codable {
   let gender: String
   let name: UserName
   let email: String
   let picture: UserPictures
}

struct UserName: Codable {
   let title: String
   let first: String
   let last: String
}

struct UserPictures: Codable {
   let large: String
   let medium: String
   let thumbnail: String
}
