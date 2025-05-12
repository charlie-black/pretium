# Pretium Flutter App

**Pretium** is a Flutter-based mobile application designed to simplify crypto payments with an intuitive sign-up and login experience. Built with modern Flutter architecture and smooth routing using `go_router`, it provides a fast and secure user onboarding flow.

## 🚀 Features

- 🔐 Secure Sign-up and Login Flow
- 🔄 Seamless Navigation using `go_router`
- 💡 Modular UI Components for Reusability
- 📱 Support for Android and iOS Devices
- 🛠️ Ready for Firebase Integration (Optional)

## 🧰 Prerequisites

Before you begin, ensure the following tools are installed:

- **Flutter SDK**: Version `3.13` or later (stable channel recommended)
- **Dart**: Included with Flutter
- **Git**: For version control
- **IDE**: Android Studio, VS Code, or any Flutter-supported IDE
- **Emulator or Device**: For running the application
- **Firebase (Optional)**: For authentication or backend
- **Node.js (Optional)**: If using external tooling/scripts

## 📦 Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd pretium

```
### 2. Install Dependencies
```bash
flutter pub get
```
### 3. Run the Application
```bash
flutter run
```
### 4. Build for Release (Optional)
```bash
flutter build apk --release
```
### 5. Run Tests (Optional)
```bash
flutter test
```
### 6. Lint the Code (Optional)
```bash
flutter analyze
```
### 7. Format the Code (Optional)
```bash
flutter format .
```
### 8. Run on Web (Optional)
```bash
flutter run -d chrome
```
### 9. Run on Desktop (Optional)
```bash
flutter run -d windows
```
### 10. Run on iOS (Optional)
```bash
flutter run -d ios
```
### 11. Run on macOS (Optional)
```bash
flutter run -d macos
```
### 12. Run on Linux (Optional)
```bash
flutter run -d linux
```
### 13. Project Structure
```bash
pretium/
├── android/              # Android platform-specific code
├── ios/                  # iOS platform-specific code
├── lib/                  # Main Flutter source code
│   ├── components/       # Reusable widgets (e.g., CustomButton, CustomTextField)
│   ├── utils/            # Utility helpers (e.g., colors, styles)
│   ├── main.dart         # App entry point and GoRouter config
│   └── ...               # Additional features and screens
├── pubspec.yaml          # Flutter dependencies and assets
└── README.md             # Project documentation


