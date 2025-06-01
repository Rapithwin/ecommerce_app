# e_commerce

A demo e-commerce Flutter app for university and portfolio purposes.

## Overview

This project is a modern e-commerce mobile application built with Flutter. It demonstrates clean architecture, Bloc state management, and integration with a custom REST API backend (backend not included in this repository).

**Features:**

- Product listing and details
- User authentication
- Shopping cart
- Favorites (wishlist)
- Comments and product reviews
- Profile management

## Architecture

- **State Management:** Bloc (flutter_bloc)
- **Architecture:** Clean architecture (separation of data, domain, and presentation layers)
- **API:** Consumes a custom REST API backend

## Screenshots

## Getting Started (Android)

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (3.x recommended)
- Android Studio or VS Code
- An Android device or emulator

### Setup

1. **Clone the repository:**
   ```powershell
   git clone https://github.com/Rapithwin/ecommerce_app.git
   cd ecommerce_app
   ```
2. **Install dependencies:**
   ```powershell
   flutter pub get
   ```
3. **Run the app:**
   ```powershell
   flutter run
   ```

> **Note:**
>
> - The app expects a running backend REST API. You may need to update API endpoints in the code to match your backend server.
> - This project is for demonstration and educational purposes.

## Folder Structure

- `lib/` - Main app code (features, blocs, UI, etc.)
- `packages/` - Data and repository layers (clean architecture)
- `assets/` - Images and other static assets

## License

This project is for educational and portfolio use. Contact the author for other uses.

---

Feel free to fork, use, and adapt for your own learning!
