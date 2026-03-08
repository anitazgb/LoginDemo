import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                    .accessibilityIdentifier("successIcon")

                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityIdentifier("welcomeTitle")

                Text("You are logged in as\n\(viewModel.email)")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .accessibilityIdentifier("loggedInLabel")

                Spacer()

                Button(action: { viewModel.logout() }) {
                    Text("Sign Out")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
                .accessibilityIdentifier("logoutButton")
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
