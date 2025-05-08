# ✅ **MyTodoApp Documentation**

## 📱 Overview

**MyTodoApp** is a cross-platform mobile application built with **Flutter**, designed to help users efficiently manage their daily tasks. Whether you're a student, a professional, or a general user, this app provides a clean interface to create, view, update, and delete todos.

* **Platform:** Flutter (Android & iOS)
* **Goal:** Streamline task management
* **Target Users:** Students, professionals, everyday users

---

## 🚀 Key Features

* ✅ Create todos with **title**, **description**, and **category**
* ✅ Edit existing todos
* ✅ View detailed todo information (description, creation date)
* ✅ Mark todos as **completed**
* ✅ Filter by status: **All**, **Completed**, **Pending**
* ✅ Select categories like **Personal** or **Work**
* 🔜 Add due dates and flag **overdue** tasks
* 🔜 Search todos via a **search bar**
* 🔜 Delete todos via **swipe** or **long-press confirmation**

---

## 🧱 Architecture Overview

* **State Management:** `Provider`
* **Design Pattern:** MVVM-lite
* **Core Components:**

    * `HomeScreen`: Main list with filters
    * `AddTodoScreen`: Form for adding/editing todos
    * `TodoDetailsScreen`: Full view with optional edit
    * `TodoProvider`: Central business logic & state

### 📁 Folder Structure

```
lib/
 ├── models/
 │    └── todo.dart
 ├── providers/
 │    └── todo_provider.dart
 ├── screens/
 │    ├── home_screen.dart
 │    ├── add_todo_screen.dart
 │    └── todo_details_screen.dart
 └── main.dart
```

---

## 🛠️ Technology Stack

* **Framework:** Flutter
* **Language:** Dart
* **State Management:** Provider
* **Date Utilities:** `showDatePicker`, `intl` (optional)
* **UI Components:** ListView, Dismissible, Dialogs, TextFields, DropdownButton, Chips

---

## ⚙️ Installation Guide

### Prerequisites

* Flutter SDK (v3.0.0 or higher)
* Android Studio or VS Code with Flutter plugins

### Setup Instructions

```bash
git clone https://github.com/andremugabo/MyTodoApp.git
cd mytodoapp
flutter pub get
flutter run
```

---

## 🥪 Testing

```bash
flutter test
```

> Manual testing is currently in place. Unit and widget testing will be added in upcoming versions.

---

## 👤 User Instructions

1. Launch the application
2. Tap the **"+"** icon to add a todo
3. Fill in details: title, description, category, and optionally due date
4. Tap on any todo to view more information
5. Swipe a todo to delete (confirmation required)
6. Use filter chips to toggle between task statuses

---

## 👨‍💻 Developer Guidelines

### Adding Features

* Extend the `Todo` model
* Update logic in `TodoProvider`
* Add form fields in `AddTodoScreen`
* Update UI in `HomeScreen` and `TodoDetailsScreen`

### Best Practices

* Use meaningful variable and method names
* Always call `notifyListeners()` after state updates
* Keep UI logic separate from business/data logic

---

## 🔐 Security Notes

* This version stores data **locally only**
* Plans to integrate **Firebase Auth** or **Secure Storage** in the future

---

## 🛯️ Common Issues & Fixes

| Issue                | Recommended Fix                              |
| -------------------- | -------------------------------------------- |
| App won’t build      | Run `flutter clean && flutter pub get`       |
| State not refreshing | Ensure `notifyListeners()` is called         |
| Date not showing     | Review `showDatePicker` usage and formatting |

---

## 📦 Deployment

To build the release versions:

```bash
flutter build apk      # For Android
flutter build ios      # For iOS
```

---

## 📚 Version History

### v1.0.0 – Initial Release

* Full CRUD (Create, Read, Update, Delete) support
* Status filtering
* View todo details

### v1.1.0 – Coming Soon

* Due dates and overdue status tags
* Search feature
* Category UI filters using chips