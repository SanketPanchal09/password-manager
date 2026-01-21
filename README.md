# Password Manager App Documentation

## Overview

The Password Manager app allows users to securely store and manage their login credentials—such as account names, usernames/emails, and passwords—locally using Realm. Users can easily add, view, update, and delete their saved credentials through a clean and intuitive interface.

---

## Build & Run Instructions

### 1. Clone the Project

If you're using GitHub or another source:

```bash
git clone https://github.com/your-repo/password-manager.git
cd password-manager
```

### 2. Open in Xcode

Open the project file:

```bash
open PasswordManager.xcodeproj
```

### 3. Select a Device or Simulator

- In Xcode's top bar, choose a simulator (e.g., iPhone 15), or
- Connect your physical iOS device and select it

### 4. Run the App

- Click the **Play** button in the top toolbar
- Or use the keyboard shortcut: `Cmd + R`

---

## Using the App

### Adding a New Account

1. Tap the **Add (+)** floating button
2. A red bottom sheet will appear
3. Enter the following details:
   - Account Name (e.g., Instagram)
   - Username or Email
   - Password
4. Tap **"Add New Account"**
5. Your entry is saved locally using Realm

### Viewing, Editing, or Deleting an Existing Account

1. Tap on any saved account from the list
2. A detail sheet will slide up
3. From here, you can:
   - View stored username/email and password
   - Edit and update the information
   - Delete the account by tapping the **Delete** button at the bottom of the sheet
4. Tap **"Update Account"** to save any changes

---

## Data Storage

- All credentials are stored locally on the device using the Realm database
- The Realm file path is printed in the Xcode console using:

```swift
print(Realm.Configuration.defaultConfiguration.fileURL!)
```

### Viewing the Database in Realm Studio

1. Download Realm Studio: [Download v15.2.1](https://studio-releases.realm.io/v15.2.1)
2. When on the **AccountsList** screen, note the printed file path from the Xcode console
3. Open the `.realm` file using Realm Studio to view and inspect stored data

