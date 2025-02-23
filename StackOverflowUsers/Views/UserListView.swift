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
                        UserRow(user: user,
                                isFollowed: viewModel.isUserFollowed(userId: user.userId),
                                onFollowTapped: {
                                    viewModel.toggleFollow(for: user.userId)
                                })
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
