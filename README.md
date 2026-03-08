# LoginDemo — iOS Automation Testing Practice Project

A SwiftUI login app built specifically for learning iOS test automation.
It has a **Login screen** and a **Home screen**, with unit tests and UI tests ready to run.

---

## 📁 Project Structure

```
LoginDemo/
├── LoginDemo/                    ← App source code
│   ├── LoginDemoApp.swift        ← App entry point (@main)
│   ├── ContentView.swift         ← Root view (switches Login ↔ Home)
│   ├── ViewModels/
│   │   └── AuthViewModel.swift   ← All login/logout logic (what you test!)
│   └── Views/
│       ├── LoginView.swift       ← Login screen UI
│       └── HomeView.swift        ← Home screen (shown after login)
│
├── LoginDemoTests/               ← Unit tests (test logic, no UI)
│   └── AuthViewModelTests.swift
│
├── LoginDemoUITests/             ← UI tests (tap buttons, check screens)
│   └── LoginUITests.swift
│
└── LoginDemo.xcodeproj/          ← Xcode project file
```

---

## 🚀 Part 1: Set Up the Project (First Time)

### Step 1 — Clone or create the repo

If you received this project as a zip, or want to start fresh on GitHub:

```bash
# Navigate to where you want the project
cd ~/Developer   # or wherever you keep code

# If the folder is already here, just enter it:
cd LoginDemo

# Check what's inside
ls -la
```

### Step 2 — Initialize Git

```bash
# Inside the LoginDemo folder:
git init

# See the current state (all files untracked)
git status
```

### Step 3 — Make your first commit

```bash
# Stage everything
git add .

# Commit with a message
git commit -m "initial: add LoginDemo iOS project with tests"

# Verify the commit was made
git log --oneline
```

### Step 4 — Create a GitHub repo and push

1. Go to https://github.com → click **New repository**
2. Name it `LoginDemo`
3. Set to **Public** (so you can share it)
4. **Do NOT** check "Add README" (we already have files locally)
5. Click **Create repository**
6. GitHub will show you commands — run these:

```bash
git remote add origin https://github.com/YOUR_USERNAME/LoginDemo.git
git branch -M main
git push -u origin main
```

### Step 5 — Open in Xcode

```bash
# From the LoginDemo directory:
open LoginDemo.xcodeproj
```

---

## 🧪 Part 2: Running Tests in Xcode

### Run all tests
Press **⌘U** — this builds the app and runs every test.

### Run a single test
Click the **▶️ diamond** icon in the gutter next to any test function.

### See results
- **Green ✅** = test passed
- **Red ❌** = test failed — click to see the error message

### Test Navigator
Press **⌘6** to open the Test Navigator panel on the left.
You can run, filter, and see all test results here.

---

## 🌿 Part 3: The Daily Git Workflow

This is what you do for every piece of test work.

### Step 1 — Always start from latest main

```bash
git checkout main
git pull origin main
```

### Step 2 — Create a branch for your work

```bash
# Format: test/what-you're-doing
git checkout -b test/add-login-error-tests

# Confirm you're on the new branch
git branch
```

### Step 3 — Make changes in Xcode

Edit test files, add new tests, fix broken ones.
Run with **⌘U** until everything is green.

### Step 4 — Check what you changed

```bash
git status          # which files changed
git diff            # see the exact lines changed
```

### Step 5 — Commit your work

```bash
# Stage specific files (recommended)
git add LoginDemoTests/AuthViewModelTests.swift

# Or stage everything
git add .

# Commit with a descriptive message
git commit -m "test: add error message tests for invalid login"
```

**Good commit message format:**
```
test: add UI tests for logout button
fix: update selector for renamed loginButton
refactor: extract helper for login flow in UI tests
```

### Step 6 — Push your branch to GitHub

```bash
git push origin test/add-login-error-tests
```

### Step 7 — Open a Pull Request

1. Go to your repo on **GitHub.com**
2. You'll see a yellow banner: **"Compare & pull request"** — click it
3. Fill in the PR description (see template below)
4. Click **"Create pull request"**

### Step 8 — After PR is merged, clean up

```bash
git checkout main
git pull origin main
git branch -d test/add-login-error-tests   # delete local branch
```

---

## ✍️ PR Description Template

Use this every time you open a PR:

```markdown
## What does this PR do?
[Short description of what tests you added or fixed]

## Tests added / changed
- `testXxx` — what it verifies
- `testYyy` — what it verifies

## How to verify
1. Open LoginDemo.xcodeproj in Xcode
2. Run tests with ⌘U
3. All tests should pass ✅

## Notes
[Anything reviewers should know]
```

---

## 🏋️ Part 4: Practice Exercises

Work through these in order. Each one is a full branch → test → PR cycle.

### Exercise 1 — Fix a flaky test (Easy)
**Branch:** `fix/flaky-login-test`

The `testLoginWithValidCredentials` unit test uses `asyncAfter` — 
this can be unreliable. Research `XCTestExpectation` and rewrite it to be more robust.

### Exercise 2 — Add missing test cases (Medium)
**Branch:** `test/edge-case-email-validation`

Add these missing test cases to `AuthViewModelTests`:
- Email with spaces should fail
- Email that is just spaces should fail  
- Very long valid email should pass
- Email with consecutive dots should fail

### Exercise 3 — Add a new UI test (Medium)
**Branch:** `test/ui-invalid-email-shows-error`

In `LoginUITests`, add a test that:
1. Types an invalid email (e.g. `notanemail`)
2. Types a valid password
3. Verifies the login button is **disabled**

### Exercise 4 — Write a Page Object (Advanced)
**Branch:** `refactor/page-object-pattern`

The Page Object pattern makes UI tests more maintainable.
Create a `LoginPage.swift` file in `LoginDemoUITests/` that wraps
all the element finders and interactions. Then refactor `LoginUITests.swift`
to use it.

```swift
// LoginPage.swift — starter
struct LoginPage {
    let app: XCUIApplication
    
    var emailField: XCUIElement { app.textFields["emailField"] }
    var passwordField: XCUIElement { app.secureTextFields["passwordField"] }
    var loginButton: XCUIElement { app.buttons["loginButton"] }
    
    func login(email: String, password: String) {
        emailField.tap()
        emailField.typeText(email)
        passwordField.tap()
        passwordField.typeText(password)
        loginButton.tap()
    }
}
```

---

## 🔑 Demo Credentials

| Email | Password | Result |
|-------|----------|--------|
| test@example.com | password123 | ✅ Login success |
| test@example.com | wrongpassword | ❌ Error shown |
| anything else | anything | ❌ Error shown |

---

## 📚 Key Commands Reference

```bash
# Git daily commands
git status                          # what changed?
git diff                            # see exact changes
git add .                           # stage all
git add path/to/file.swift          # stage one file
git commit -m "message"             # commit
git push origin branch-name         # push to GitHub
git pull origin main                # get latest
git checkout -b new-branch-name     # create + switch branch
git checkout branch-name            # switch branch
git branch                          # list branches
git log --oneline                   # see commit history
git branch -d branch-name           # delete local branch

# Xcode shortcuts
⌘U        Run all tests
⌘B        Build only
⌘6        Test Navigator
⌃⌥⌘U     Run tests in current file
```
