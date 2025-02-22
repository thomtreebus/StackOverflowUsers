import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if !viewModel.users.isEmpty {
                    Text("users")
                    
                } else {
                    ErrorView(message: "error") {
                        
                    }
                }
            }
            .navigationTitle("StackOverflow Users")
        }
    }
}
