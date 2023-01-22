//
//  POCTaskAsyncAwaitApp.swift
//  POCTaskAsyncAwait
//
//  Created by Herve Peroteau on 21/01/2023.
//

import SwiftUI

@main
struct POCTaskAsyncAwaitApp: App {
   var body: some Scene {
      WindowGroup {
         UsersListView()
            .environmentObject(UsersListViewModel())
      }
   }
}
