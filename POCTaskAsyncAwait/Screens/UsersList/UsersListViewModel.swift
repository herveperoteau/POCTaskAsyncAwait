//
//  UsersListViewModel.swift
//  POCTaskAsyncAwait
//
//  Created by Herve Peroteau on 22/01/2023.
//

import Foundation
import RxSwift

class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    
    let clientApi = RandomUsersClientApi()
    let pageSize = 20
    let bag = DisposeBag()
    
    public func loadDatasRx(reset: Bool = true) {
        
        if reset {
            self.users = []
        }
        
        isLoading = true
        
        clientApi.fetchUsersRx(count: pageSize)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] in
                self?.users = $0
                self?.isLoading = false
            })
            .disposed(by: bag)
    }
    
    public func loadDatas(reset: Bool = true) {
        NSLog("loadDatas isMainThread: \(Thread.isMainThread)")
        Task {
            NSLog("loadDatas Task isMainThread: \(Thread.isMainThread)")
            if reset {
                await resetUsers()
            }
            await setIsLoading(true)
            await fetchUsers()
            await setIsLoading(false)
        }
    }
    
    private func fetchUsers() async {
        NSLog("loadDatas fetchUsers isMainThread: \(Thread.isMainThread)")
        do {
            // Fake  slow server
            try await Task.sleep(nanoseconds: 2_000_000_000)
            
            let users = try await clientApi.fetchUsers(count: pageSize)
            await addUsers(users)
        } catch {
            NSLog("Error: \(error) !!!")
        }
    }
    
    @MainActor
    private func setIsLoading(_ value: Bool) async {
        NSLog("loadDatas setIsLoading isMainThread: \(Thread.isMainThread)")
        self.isLoading = value
    }
    
    @MainActor
    private func addUsers(_ users: [User]) async {
        NSLog("loadDatas addUsers isMainThread: \(Thread.isMainThread)")
        self.users += users
    }
    
    @MainActor
    private func resetUsers() async {
        NSLog("loadDatas resetUsers isMainThread: \(Thread.isMainThread)")
        self.users = []
    }
}
