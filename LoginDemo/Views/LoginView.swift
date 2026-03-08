import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Logo area
            VStack(spacing: 12) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 64))
                    .foregroundColor(.blue)
                    .accessibilityIdentifier("appLogo")

                Text("LoginDemo")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Sign in to your account")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 48)

            // Form
            VStack(spacing: 16) {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .accessibilityIdentifier("emailField")

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .accessibilityIdentifier("passwordField")

                // Error message
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("errorMessage")
                }

                // Reset password button
                Button(action: { viewModel.resetPassword() }) {
                    Text("Reset Password")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .accessibilityIdentifier("resetPasswordButton")

                // Login button
                Button(action: { viewModel.login() }) {
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Sign In")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isFormValid ? Color.blue : Color.blue.opacity(0.4))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(!viewModel.isFormValid || viewModel.isLoading)
                .accessibilityIdentifier("loginButton")
            }
            .padding(.horizontal, 32)

            Spacer()

            // Hint for demo
            VStack(spacing: 4) {
                Text("Demo credentials:")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text("test@example.com / password123")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .accessibilityIdentifier("demoCredentialsLabel")
            }
            .padding(.bottom, 32)
        }
    }
}
