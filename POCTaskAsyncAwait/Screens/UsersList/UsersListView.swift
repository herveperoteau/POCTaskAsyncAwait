//
//  UsersListView.swift
//  POCTaskAsyncAwait
//
//  Created by Herve Peroteau on 21/01/2023.
//

import SwiftUI

struct UsersListView: View {

   @EnvironmentObject var viewModel: UsersListViewModel

   var body: some View {
       
       VStack {
           List(viewModel.users) { user in
               HStack {
                   Text(user.name.title)
                   Text(user.name.first)
                   Text(user.name.last)
               }
           }
           
           if viewModel.isLoading {
               Text("Loading ...")
           }
       }
      .refreshable {
         viewModel.loadDatas()
      }
      .onAppear {
         viewModel.loadDatas()
      }
   }
}

struct UsersListView_Previews: PreviewProvider {

   static var viewModel: UsersListViewModel = {
      let vm = UsersListViewModel()
//      vm.users = [
//         User(
//            gender: "female",
//            name: UserName(
//               title: "Mrs",
//               first: "Angelina",
//               last: "Smith"),
//            email: "angelina.smith@fake.com",
//            picture: UserPictures(
//               large: "https://randomuser.me/api/portraits/women/77.jpg",
//               medium: "https://randomuser.me/api/portraits/med/women/77.jpg",
//               thumbnail: "https://randomuser.me/api/portraits/thumb/women/77.jpg"),
//            login: UserLogin(uuid: UUID().uuidString))
//      ]
      return vm
   }()

   static var previews: some View {
      UsersListView()
         .environmentObject(viewModel)
   }
}
