Pretium Flutter App
A Flutter application for simplifying crypto payments, featuring a user-friendly sign-up and login flow.
Prerequisites
Before you begin, ensure you have the following installed:
Flutter SDK: Version 3.13 or later (stable channel recommended)

Dart: Included with Flutter

Git: For cloning the repository

IDE: Android Studio, VS Code, or any Flutter-supported IDE

Android/iOS Emulator or Physical Device: For running the app

Firebase (Optional): If the app uses Firebase for authentication or backend services

Node.js (Optional): If additional scripts or tools are required

Getting Started
Follow these steps to clone and run the app locally:
1. Clone the Repository
   Clone the repository from GitHub (replace <repository-url> with the actual URL of your repository):
   bash

git clone <repository-url>
cd pretium

2. Install Dependencies
   Navigate to the project directory and install the required Flutter dependencies:
   bash

flutter pub get

This will download all dependencies listed in the pubspec.yaml file, including go_router, flutter, and any custom packages.
se a package like flutter_dotenv to load environment variables if required.

3. Run the App
   Connect a physical device or start an emulator/simulator, then run the app:
   bash

flutter run

To run in a specific mode (e.g., debug, release):
bash

flutter run --debug
flutter run --release

If you encounter issues, ensure your Flutter environment is correctly set up by running:
bash

flutter doctor

Resolve any reported issues before proceeding.
4. Build the App (Optional)
   To build the app for deployment:
   Android:
   bash

flutter build apk --release

The output APK will be located in build/app/outputs/flutter-apk/app-release.apk.

iOS:
bash

flutter build ios --release

Then, open ios/Runner.xcworkspace in Xcode to archive and distribute the app.

Project Structure
Here’s an overview of the project’s key directories and files:

pretium/
├── android/              # Android-specific files
├── ios/                  # iOS-specific files
├── lib/                  # Main Flutter source code
│   ├── components/       # Reusable UI components (e.g., CustomButton, CustomTextField)
│   ├── utils/            # Utility files (e.g., color_constants.dart, text_styling.dart)
│   ├── main.dart         # Entry point of the app
│   └── ...               # Other app screens and logic
├── pubspec.yaml          # Flutter dependencies and configuration
└── README.md             # This file

Dependencies
Key dependencies used in the app:
flutter: Core Flutter framework

go_router: For navigation and routing

Other dependencies are listed in pubspec.yaml.

To add a new dependency, edit pubspec.yaml and run flutter pub get.
Navigation
The app uses go_router for navigation. Key routes include:
/login: Login page

/sign_up: Sign-up page

/verify_account: Account verification page

Update the GoRouter configuration in lib/main.dart or the relevant routing file to add new routes.
Troubleshooting
Dependency Issues: If flutter pub get fails, try:
bash

flutter clean
flutter pub get

Build Errors: Ensure your Flutter SDK is up to date and that flutter doctor reports no issues.

Navigation Issues: Verify that all routes are correctly defined in the GoRouter setup.


Contributing
To contribute to the project:
Fork the repository.

Create a new branch (git checkout -b feature/your-feature).

Make your changes and commit (git commit -m "Add your feature").

Push to the branch (git push origin feature/your-feature).

Open a pull request.

License
This project is licensed under the MIT License (LICENSE) (or specify your license).

