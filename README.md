<div align="center">

<img src="assets/app_icon.png" alt="Mindful App Icon" width="110" style="border-radius: 22px;" />

# Mindful — Todo & Task Management

A clean, modern, and mindful productivity app designed to keep your daily tasks organized with peace of mind. Built with Flutter, Material 3, and cloud synchronization.

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![GitHub Release](https://img.shields.io/github/v/release/FlameOf9-11/Mindful-todo?style=for-the-badge&color=345444)](https://github.com/FlameOf9-11/Mindful-todo/releases/latest)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=for-the-badge)](https://github.com/FlameOf9-11/Mindful-todo)

[Download APK](https://github.com/FlameOf9-11/Mindful-todo/releases/latest) • [Features](#-features) • [Quick Start](#-getting-started) • [Architecture](#-project-structure) • [Tech Stack](#-tech-stack)

</div>

---

## 📱 About Mindful

**Mindful** is a distraction-free task manager tailored for clarity and ease of use. It pairs an earthy, calming aesthetic with reliable cloud-backed task persistence, allowing you to capture ideas, organize daily goals, and check off accomplishments with smooth transitions and instant feedback.

### 🌟 Key Highlights

- 🌿 **Calming Visual Design**: Crafted with Material 3, dark graphite backdrops (`#1E1F22`), warm card surfaces, and rich forest green accents (`#345444`).
- 🔒 **Secure Authentication**: End-to-end user registration and login backed by JWT token security.
- 💾 **Persistent Sessions**: Seamless automatic login powered by hardware-backed encrypted storage (`flutter_secure_storage`).
- ⚡ **Real-time Task Sync**: Complete CRUD (Create, Read, Update, Delete) operations connected directly to the cloud backend.
- 🎯 **Smart Filters**: Quickly toggle views between **All**, **Active**, and **Completed** tasks.
- 🔔 **Global Notifications**: System-wide SnackBar feedback for instant connection and action notifications.

---

## 🚀 Features

### 1. Authentication & Security
- **Sign Up**: Create an account with validated email and password credentials.
- **Sign In**: Fast login with credential verification.
- **Session Auto-Resume**: The app detects stored credentials on boot and routes directly to your task list.
- **Safe Sign Out**: One-tap logout that cleans stored tokens from device memory.

### 2. Task Management
- **Add Tasks**: Add tasks with mandatory titles and optional detailed descriptions.
- **Completion Toggle**: Check and uncheck tasks with interactive checkboxes.
- **Edit & Update**: Modify existing tasks on the fly.
- **Swipe / Delete**: Remove finished or outdated tasks instantly.
- **Task Filtering**: Filter your view to focus on ongoing goals or review completed items.

---

## 📥 Download & Install

You can immediately install the latest pre-compiled Android release:

1. Head to the [Latest GitHub Release](https://github.com/FlameOf9-11/Mindful-todo/releases/latest).
2. Download [`app-release.apk`](https://github.com/FlameOf9-11/Mindful-todo/releases/download/v1.0.0/app-release.apk).
3. Open the APK on your Android device and confirm installation.

---

## 🛠️ Tech Stack & Dependencies

| Category | Technology | Purpose |
| :--- | :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) | Cross-platform UI toolkit |
| **Language** | [Dart](https://dart.dev) | Modern typed language |
| **Networking** | [Dio](https://pub.dev/packages/dio) & [Http](https://pub.dev/packages/http) | REST API requests and interceptors |
| **Secure Storage** | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) | Keychain & KeyStore encrypted token persistence |
| **Typography** | [google_fonts](https://pub.dev/packages/google_fonts) | Clean typography |
| **Icons** | [cupertino_icons](https://pub.dev/packages/cupertino_icons) & [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) | Adaptive icons & launcher branding |

---

## 🏗️ Project Structure

```text
lib/
├── core/
│   └── theme/
│       └── app_colors.dart        # Unified color palette & style constants
├── models/
│   ├── api_client.dart            # Dio HTTP client configuration & interceptors
│   ├── api_endpoints.dart         # Base URLs and backend endpoint routes
│   ├── auth_service.dart          # Login, registration, and credential logic
│   ├── todo.dart                  # Todo model with JSON serialization & copyWith
│   ├── todo_filter.dart           # Filter state helper (All, Active, Completed)
│   ├── todo_service.dart          # REST API operations for todos (CRUD)
│   └── token_storage.dart         # Encrypted JWT token persistence
├── routes/
│   ├── app_router.dart            # Route generator & transitions
│   └── app_routes.dart            # Named route string constants
├── screens/
│   ├── login_screen.dart          # User authentication & login UI
│   ├── signup_screen.dart         # New user registration screen
│   └── todo_screen.dart           # Primary task dashboard, filter bar & list
└── main.dart                      # App entry point & initial route resolver
```

---

## 💻 Getting Started (Local Development)

Follow these steps to run the application locally from source:

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.11.5` or higher)
- Android Studio, VS Code, or Antigravity IDE with Flutter & Dart extensions
- An Android Emulator, iOS Simulator, or connected physical device

### 1. Clone the Repository
```bash
git clone https://github.com/FlameOf9-11/Mindful-todo.git
cd Mindful-todo/flutter_application_1
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the App
Launch the app in debug mode on your connected device:
```bash
flutter run
```

### 4. Build for Release
To compile a release APK for Android:
```bash
flutter build apk --release
```
The output file will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

---

## 🌐 API Reference

Mindful connects to a cloud REST API backend:

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/auth/register` | Register a new user account |
| `POST` | `/auth/login` | Authenticate user and receive JWT token |
| `GET` | `/todos` | Fetch all user tasks |
| `POST` | `/todos` | Create a new task |
| `PUT` | `/todos/{id}` | Update task title, description, or completion status |
| `DELETE` | `/todos/{id}` | Delete a task |

---

## 📄 License

This project is licensed under the terms of the MIT License. Feel free to use and adapt it for your own projects.

