import XCTest
@testable import LoginDemo

final class AuthViewModelTests: XCTestCase {

    var sut: AuthViewModel!   // sut = System Under Test

    override func setUp() {
        super.setUp()
        sut = AuthViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Email Validation
    
    // Valid email returns true
    func testValidEmailPassesValidation() {
        XCTAssertTrue(sut.isValidEmail("test@example.com"))
        XCTAssertTrue(sut.isValidEmail("user.name+tag@domain.co"))
    }

    // Invalid emails return false
    func testInvalidEmailFailsValidation() {
        XCTAssertFalse(sut.isValidEmail(""))
        XCTAssertFalse(sut.isValidEmail("notanemail"))
        XCTAssertFalse(sut.isValidEmail("missing@tld"))
        XCTAssertFalse(sut.isValidEmail("@nodomain.com"))
    }

    // MARK: - Form Validation

    // Empty fields = invalid form
    func testFormIsInvalidWhenEmpty() {
        sut.email = ""
        sut.password = ""
        XCTAssertFalse(sut.isFormValid, "Empty form should be invalid")
    }

    // Login with short password shows error message and does not log in
    func testLoginWithShortPasswordShowsError() {
        sut.email = "test@example.com"
        sut.password = "abc"
        sut.login()

        XCTAssertFalse(sut.isLoggedIn, "Should not be logged in with short password")
        XCTAssertEqual(sut.errorMessage, "Password must be at least 6 characters.", "Should show password length error")
    }

    // Valid email + password = valid form
    func testFormIsValidWithCorrectInputs() {
        sut.email = "test@example.com"
        sut.password = "password123"
        XCTAssertTrue(sut.isFormValid, "Valid email and 6+ char password should be valid")
    }

    // MARK: - Login Logic

    // Correct creds sets isLoggedIn = true
    func testLoginWithCorrectCredentialsSetsIsLoggedIn() {
        let expectation = expectation(description: "Login completes")

        sut.email = "test@example.com"
        sut.password = "password123"
        sut.login()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            XCTAssertTrue(self.sut.isLoggedIn, "Should be logged in with correct credentials")
            XCTAssertEqual(self.sut.errorMessage, "")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0)
    }

    // Wrong password shows error message
    func testLoginWithWrongPasswordShowsError() {
        let expectation = expectation(description: "Login fails with error")

        sut.email = "test@example.com"
        sut.password = "wrongpassword"
        sut.login()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            XCTAssertFalse(self.sut.isLoggedIn, "Should NOT be logged in with wrong password")
            XCTAssertFalse(self.sut.errorMessage.isEmpty, "Should show error message")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0)
    }

    // Invalid email shows validation error
    func testLoginWithInvalidEmailShowsValidationError() {
        sut.email = "not-an-email"
        sut.password = "password123"
        sut.login()

        XCTAssertFalse(sut.isLoggedIn)
        XCTAssertFalse(sut.errorMessage.isEmpty, "Should show email validation error")
    }

    // MARK: - Reset Password

    // Reset clears password field and error message
    func testResetPasswordClearsPasswordAndError() {
        sut.email = "test@example.com"
        sut.password = "wrongpassword"
        sut.errorMessage = "Invalid email or password."

        sut.resetPassword()

        XCTAssertEqual(sut.password, "", "Password should be cleared after reset")
        XCTAssertEqual(sut.errorMessage, "", "Error message should be cleared after reset")
        XCTAssertEqual(sut.email, "test@example.com", "Email should remain unchanged after reset")
    }

    // Reset does not affect login state
    func testResetPasswordDoesNotAffectLoginState() {
        sut.isLoggedIn = false
        sut.resetPassword()
        XCTAssertFalse(sut.isLoggedIn, "Login state should not change after reset")
    }

    // MARK: - Logout

    // Logout resets all fields
    func testLogoutClearsState() {
        // Arrange: simulate logged-in state
        sut.email = "test@example.com"
        sut.password = "password123"
        sut.isLoggedIn = true

        // Act
        sut.logout()

        // Assert
        XCTAssertFalse(sut.isLoggedIn)
        XCTAssertEqual(sut.email, "")
        XCTAssertEqual(sut.password, "")
        XCTAssertEqual(sut.errorMessage, "")
    }
}
