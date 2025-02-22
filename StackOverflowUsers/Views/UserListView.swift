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
                        HStack(spacing: 12) {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.displayName)
                                    .font(.headline)
                                
                                Text("Reputation: \(user.reputation)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
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
