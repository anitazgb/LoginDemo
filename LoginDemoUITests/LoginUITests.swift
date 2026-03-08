import XCTest

final class LoginUITests: XCTestCase {

    var app: XCUIApplication!
    // Creates a fresh AuthViewModel before each test
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        // Pass launch argument so app can reset state if needed
        app.launchArguments = ["-UITests"]
        app.launch()
    }
    
    // Cleans up after each test
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    // MARK: - Screen Elements Exist

    // Checks email, password, button are on screen
    func testLoginScreenElementsAreVisible() {
        XCTAssertTrue(app.textFields["emailField"].exists, "Email field should be visible")
        XCTAssertTrue(app.secureTextFields["passwordField"].exists, "Password field should be visible")
        XCTAssertTrue(app.buttons["loginButton"].exists, "Login button should be visible")
    }

    // MARK: - Successful Login

    // Full login flow reaches Home screen
    func testLoginWithValidCredentialsNavigatesToHome() {
        // Arrange
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]
        let loginButton = app.buttons["loginButton"]

        // Act
        emailField.tap()
        emailField.typeText("test@example.com")

        passwordField.tap()
        passwordField.typeText("password123")

        loginButton.tap()

        // Assert — welcome screen should appear
        let welcomeTitle = app.staticTexts["welcomeTitle"]
        XCTAssertTrue(welcomeTitle.waitForExistence(timeout: 3), "Welcome screen should appear after login")
    }

    // MARK: - Failed Login

    // Wrong password shows error on screen
    func testLoginWithWrongPasswordShowsError() {
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]

        emailField.tap()
        emailField.typeText("test@example.com")

        passwordField.tap()
        passwordField.typeText("wrongpass")

        app.buttons["loginButton"].tap()

        let errorMessage = app.staticTexts["errorMessage"]
        XCTAssertTrue(errorMessage.waitForExistence(timeout: 3), "Error message should appear")
    }

    // Button disabled when fields empty
    func testLoginButtonIsDisabledWithEmptyFields() {
        let loginButton = app.buttons["loginButton"]
        // Button should be disabled (dimmed) when fields are empty
        XCTAssertFalse(loginButton.isEnabled, "Login button should be disabled when fields are empty")
    }

    // MARK: - Reset Password

    // Reset button clears the password field
    func testResetPasswordButtonClearsPasswordField() {
        let passwordField = app.secureTextFields["passwordField"]

        passwordField.tap()
        passwordField.typeText("somepassword")

        app.buttons["resetPasswordButton"].tap()

        XCTAssertEqual(passwordField.value as? String, "Password", "Password field should be empty after reset (shows placeholder)")
    }

    // Reset button clears error message from screen
    func testResetPasswordButtonClearsErrorMessage() {
        app.textFields["emailField"].tap()
        app.textFields["emailField"].typeText("test@example.com")
        app.secureTextFields["passwordField"].tap()
        app.secureTextFields["passwordField"].typeText("wrongpass")
        app.buttons["loginButton"].tap()

        XCTAssertTrue(app.staticTexts["errorMessage"].waitForExistence(timeout: 3), "Error should appear first")

        app.buttons["resetPasswordButton"].tap()

        XCTAssertFalse(app.staticTexts["errorMessage"].exists, "Error message should disappear after reset")
    }

    // MARK: - Logout

    // Logout brings back Login screen
    func testLogoutReturnsToLoginScreen() {
        // First log in
        app.textFields["emailField"].tap()
        app.textFields["emailField"].typeText("test@example.com")
        app.secureTextFields["passwordField"].tap()
        app.secureTextFields["passwordField"].typeText("password123")
        app.buttons["loginButton"].tap()

        // Wait for home screen
        XCTAssertTrue(app.buttons["logoutButton"].waitForExistence(timeout: 3))

        // Tap logout
        app.buttons["logoutButton"].tap()

        // Should be back on login screen
        XCTAssertTrue(app.textFields["emailField"].waitForExistence(timeout: 2),
                      "Should return to login screen after logout")
    }
}
