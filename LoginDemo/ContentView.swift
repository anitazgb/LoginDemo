import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
        if authViewModel.isLoggedIn {
            HomeView(viewModel: authViewModel)
        } else {
            LoginView(viewModel: authViewModel)
        }
    }
}
