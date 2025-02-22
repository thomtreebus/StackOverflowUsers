import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if let error = viewModel.error {
                    ErrorView(message: error.message) {
                        Task {
                            await viewModel.loadUsers()
                        }
                    }
                } else {
                    List(viewModel.users) { user in
                        UserRow(user: user)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("StackOverflow Users")
            .task {
                await viewModel.loadUsers()
            }
        }
    }
}
