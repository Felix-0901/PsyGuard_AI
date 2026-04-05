# PsyGuard AI

PsyGuard AI is an AI-driven mental health support and companionship tool designed to provide users with a secure and empathetic platform. Built with Flutter, this MVP application leverages artificial intelligence to offer guided assistance, track emotional trends, and act as a reliable daily companion for mental wellness.

## Key Features

- **AI Companionship:** Engage with a conversational AI designed to provide emotional support and guidance.
- **Voice Interaction:** Supports natural communication through Speech-to-Text and Text-to-Speech capabilities.
- **Trend Tracking:** Visualize emotional well-being over time with interactive charts.
- **Secure Local Storage:** Ensures user data privacy by utilizing securely encrypted local content and databases.
- **Fluid Navigation:** Seamless user experience with a robust routing architecture.

## Tech Stack

The application is built using the Flutter framework and incorporates the following core libraries:

- **Framework:** Flutter (Dart)
- **State Management:** Riverpod (flutter_riverpod)
- **Routing:** Go Router (go_router)
- **Local Database:** Drift (drift) and SQLite
- **Networking:** Dio (dio)
- **Data Visualization:** FL Chart (fl_chart)
- **Voice APIs:** speech_to_text and flutter_tts
- **Markdown Rendering:** flutter_markdown

## Project Structure

The repository contains the main application under the `psyguard_ai_app` directory. Key operations should be executed within this directory.

## Getting Started

Follow these steps to set up the project locally.

### Prerequisites

- Flutter SDK (compatible with version ^3.9.2 constraints)
- Xcode (for iOS development and testing)
- Android Studio (for Android development and testing)
- CocoaPods (for iOS dependencies)

### Installation

1. Navigate to the application directory:
   ```bash
   cd psyguard_ai_app
   ```

2. Install Dart dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Environment Variables:
   - Create a `.env` file in the `psyguard_ai_app` directory.
   - Use the existing `.env.example` as a template for required keys (e.g., API tokens).

4. Generate Generated Code (Drift Database, etc.):
   ```bash
   dart run build_runner build -d
   ```

5. Install iOS Dependencies (If running on iOS):
   ```bash
   cd ios
   pod install
   cd ..
   ```

6. Run the application:
   ```bash
   flutter run
   ```

## License

This project is licensed under the terms provided in the LICENSE file.
