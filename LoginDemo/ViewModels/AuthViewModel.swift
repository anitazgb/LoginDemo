import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false

    // Hardcoded credentials for demo purposes
    private let validEmail = "test@example.com"
    private let validPassword = "password123"

    var isFormValid: Bool {
        isValidEmail(email) && password.count >= 6
    }

    func isValidEmail(_ email: String) -> Bool {
        let regex = #"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }

    func login() {
        errorMessage = ""

        guard isFormValid else {
            if !isValidEmail(email) {
                errorMessage = "Please enter a valid email address."
            } else if password.count < 6 {
                errorMessage = "Password must be at least 6 characters."
            }
            return
        }

        isLoading = true

        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false

            if self.email == self.validEmail && self.password == self.validPassword {
                self.isLoggedIn = true
            } else {
                self.errorMessage = "Invalid email or password."
            }
        }
    }

    func resetPassword() {
        password = ""
        errorMessage = ""
    }

    func logout() {
        email = ""
        password = ""
        errorMessage = ""
        isLoggedIn = false
    }
}
