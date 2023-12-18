## eBook App
# Description
The eBook App is a mobile application developed using Flutter, designed to provide users with a convenient and enjoyable digital reading experience. The app allows users to browse, read, and interact with a variety of PDF books stored within the app's assets. Featuring a user-friendly interface and essential functionalities for a seamless reading experience, this app is perfect for avid readers and casual browsers alike.

# Features
PDF Reading: Users can read PDF files directly within the app.
Interactive Navigation: Easy navigation through the content with a bottom navigation bar.
Customizable Viewing: Includes features like pinch-to-zoom for adjusting the view.
Page Selection: Ability to jump to a specific page through an intuitive interface.
Bookmarking System: Utilizes SQLite database for bookmarking favorite pages.
Responsive Design: Ensures a consistent user experience across various devices.

# Use Cases
Leisure Reading: Ideal for users looking to enjoy books on-the-go.
Educational Purposes: Useful for students and educators for accessing educational material.
Professional Reference: Professionals can use it to reference manuals, guides, and other materials.

# Tools and Technologies
Flutter: Cross-platform UI toolkit used for building natively compiled applications.
flutter_pdfview: A Flutter plugin for viewing PDF files.
SQLite: Used for managing user bookmarks and preferences.
Dart: Primary programming language for development.
Database Design
The app uses SQLite to manage user data. The database schema includes:

Table for bookmarks: Storing user bookmarks with fields such as bookId, pageNumber, title, and dateAdded.
Getting Started
To run the app on your device, follow these steps:

Clone the repository: git clone [repository-url].
Navigate to the project directory: cd ebook_app.
Install dependencies: flutter pub get.
Run the app: flutter run.

# Snapshots
Include snapshots of your app here to showcase its features and user interface.

Welcome Screen
Sign in / up Screens
Home Screen
Explore Screen
Reading Screen
Favorite Screen
Profile Screen

# Contributing
Contributions to the eBook App are welcome. Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.

# License
This project is licensed under the MIT License.

