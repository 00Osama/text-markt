# text markt
- Text Markt is a Flutter productivity app for managing notes and events. It allows users to create, edit, organize, search, and delete notes, as well as add and track important events.

- app also includes favorites, hidden notes with PIN protection, trash management, dark and light themes, internet connection detection, and multilingual support for Arabic, English, and French. 

- Text Markt supports note statuses to help users track their progress clearly. Each note can be marked as Pending, In Progress, or Done, making it easier to organize tasks, follow work progress, and separate unfinished notes from completed ones.

- The app uses Firebase Authentication and Cloud Firestore to provide user accounts, email verification, and cloud-based data storage. Users with unverified emails are stopped from accessing the app until their email is verified, and all user input is validated before being sent to the backend.


---


# Email Deliverability Notice

- This project currently uses Firebase Authentication's default email domain for email verification and password reset emails. As a result, some email providers (including Gmail in certain cases) may classify these emails as spam due to the shared default "firebaseapp.com" domain.

- For the production release, a dedicated custom domain will be configured for authentication emails to improve email deliverability, increase trust, and reduce the likelihood of messages being marked as spam.

---

# SCREENSHOTS
<img width="1735" height="1072" alt="Image" src="https://github.com/user-attachments/assets/a9927b41-b776-4396-95eb-ed28019ad342" />
<img width="1735" height="1072" alt="Image" src="https://github.com/user-attachments/assets/82983646-5d1e-41a7-8d27-17e8b51ac424" />
<img width="1500" height="2475" alt="Image" src="https://github.com/user-attachments/assets/afe5a15b-34d6-415d-920e-c075c5b7c6d2" />
<img width="1657" height="1357" alt="Image" src="https://github.com/user-attachments/assets/1c4bda25-8365-4748-88b8-f7c14adaee15" />
<img width="1588" height="2057" alt="Image" src="https://github.com/user-attachments/assets/6712d68e-8574-421d-aa79-b448c723e180" />
<img width="835" height="1444" alt="Image" src="https://github.com/user-attachments/assets/b1fadc91-f39f-4b14-b288-67b6c432a0e3" />

--- 


# DEMO VIDEO
app demo video: [YouTube Demo](https://youtu.be/4TOSmqpPnjk)

---

# Security

- Uses Firebase Authentication for secure user sign up, sign in, sign out, password reset, and email verification.
- Handles authentication state through an auth gate to prevent unauthorized access.
- Stops users with unverified email addresses from accessing the app until they verify their email.
- Prevents invalid emails or empty data from being submitted.
- Supports PIN protection for hidden notes to add an extra privacy layer.

---

# Dependencies

Text Markt uses a set of Flutter packages to support authentication, cloud storage, state management, localization, navigation, UI components, and app utilities.

- **Firebase Core**: Initializes Firebase services inside the Flutter app.
- **Firebase Authentication**: Handles user sign up, sign in, sign out, password reset, and email verification.
- **Cloud Firestore**: Stores users, notes, hidden notes, favorite notes, trash notes, and events in the cloud.
- **Flutter Bloc**: Manages app state for authentication, notes, events, search, theme, and language settings.
- **Go Router**: Handles app navigation between authentication pages, notes, events, profile, and other screens.
- **Shared Preferences**: Saves user preferences such as theme mode, selected language, simple local settings.
- **Intl / Flutter Localizations**: Provides multilingual support for Arabic, English, and French.
- **Connectivity Plus**: Monitors internet connection status and notifies users when they are offline.
- **Lottie**: Displays animated assets, such as the no-internet and hidden-notes animations.
- **Flutter Slidable**: Adds swipe actions for notes and events, such as delete, move to trash, hide, or favorite.
- **Google Nav Bar**: Provides the bottom navigation bar used to move between main app sections.
- **Loading Animation Widget**: Displays a loading indicator while data is loading.
- **Pull To Refresh**: Adds refresh behavior for notes and events lists.
- **Flutter Native Splash**: Generates the app splash screen.
- **Flutter Launcher Icons**: Generates custom launcher icons for Android and iOS.


---
 
# HOW TO RUN

## 1. Clone the Repository

```bash
git clone https://github.com/your-username/text_markt.git
cd text_markt
```

## 2. Install Dependencies

```bash
flutter pub get
```

## 3. Configure Firebase

Before running the project, make sure Firebase is properly configured.

Required files:

- `android/app/google-services.json` (Android)
- `ios/Runner/GoogleService-Info.plist` (iOS)
- `lib/firebase_options.dart` (generated using FlutterFire CLI)

> **Note:** The application uses **Firebase Authentication** and **Cloud Firestore**.

## 4. Run the Application

Run on the default connected device:

```bash
flutter run
```

Or run on a specific platform:

```bash
flutter run -d android
flutter run -d ios
flutter run -d chrome
```

## 5. Analyze the Project

```bash
flutter analyze
```

---
