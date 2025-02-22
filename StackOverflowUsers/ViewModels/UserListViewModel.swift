import SwiftUI

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    
    private let networkService: NetworkServiceProtocol
    private let userStore: UserStore
    
    init(networkService: NetworkServiceProtocol = NetworkService(),
         userStore: UserStore = UserStore()) {
        self.networkService = networkService
        self.userStore = userStore
    }
}
