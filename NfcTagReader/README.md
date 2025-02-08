# ManiiFest - NFC Tag Nail App

## Overview

ManiiFest is an iOS application designed for nail salons and their clients, leveraging NFC (Near Field Communication) technology to streamline information sharing and enhance the client experience. The app allows manicurists to write URLs (e.g., booking links, social media profiles) to NFC tags embedded in nail stickers or other salon materials. Clients can then simply tap their phones on the tag to access the information instantly.

## Purpose

The purpose of ManiiFest is to:

*   **Simplify Information Sharing:** Eliminate the need for clients to manually type URLs or search for salon information.
*   **Enhance Client Experience:** Provide a modern and convenient way for clients to access relevant salon resources.
*   **Boost Salon Efficiency:** Reduce the time spent providing basic information, freeing up staff to focus on services.
*   **Promote Business:** Increase visibility and engagement with salon's online presence.

## Features

*   **NFC Tag Writing:**
    *   Manicurists can write URLs to NFC tags using the app.
    *   Supports various data types in the future (e.g., contact information, appointment details).
*   **NFC Tag Reading:**
    *   Clients can scan NFC tags to instantly access the embedded URL.
*   **URL Analytics:**
    *   Tracks the number of times a URL has been written and read.
    *   Records the write and last read timestamps for each URL.
*   **User-Friendly Interface:**
    *   Clean and intuitive design for easy navigation.
    *   Modern aesthetic with customizable themes (light pink and gold).
*   **Bottom Navigation Toolbar:**
    *   Quick access to "Home," "Search," "Favorites," and "Profile" sections.
*   **Clear Instructions:**
    *   Provides simple, step-by-step instructions on how to use the app.

## Setup Instructions

1.  **Prerequisites:**
    *   Xcode (latest version) installed on your macOS system.
    *   An iOS device with NFC capabilities (iPhone 7 or later).
    *   An Apple Developer account (for testing on a real device).
2.  **Installation:**
    *   Clone the GitHub repository:
    `git clone <repository_url>`
    *   Open the `NfcTagReader.xcodeproj` file in Xcode.
    *   Connect your iOS device to your computer.
    *   In Xcode, select your device as the build target.
    *   Configure signing:
        *   Go to "Signing & Capabilities" in your project settings.
        *   Enable "Automatically manage signing".
        *   Select your team (Apple Developer account).
    *   Build and run the app on your device (Product -> Run).
3.  **NFC Setup:**
    *   Make sure NFC reading is enabled on your iPhone (Settings -> Control Center -> Customize Controls -> Add NFC Tag Reader).
    *   Obtain NFC tags compatible with iOS devices (NTAG215 is a common choice).

## How to Use

1.  **Writing to an NFC Tag (for Manicurists):**
    *   Launch the ManiiFest app on your iPhone.
    *   Enter the desired URL (e.g., your booking link) in the text field.
    *   Tap the "Set Content" button.
    *   Hold your iPhone near the NFC tag. The app will write the URL to the tag.
2.  **Reading an NFC Tag (for Clients):**
    *   Make sure NFC reading is enabled on your iPhone.
    *   Open the ManiiFest app.
    *   Tap your iPhone near the NFC tag on the client's nail or other salon material.
    *   The app will automatically read the URL and open it in Safari.

## File Structure

The project is structured as follows:

*   `Constants.swift`: Defines global string constants (e.g., `mimeTypeKey`, `payloadKey`).
*   `ContentView.swift`: The main view of the app, including the UI and logic for interacting with the `NFCManager`.
*   `DataInputView.swift`: A reusable view for entering data (e.g., URL).
*   `NFCManager.swift`: The core class for managing NFC sessions and handling NFC tag interactions.
*   `NFCManager+MessageCreation.swift`: Extension to `NFCManager` for creating NDEF messages.
*   `NFCManager+NDEFHandling.swift`: Extension to `NFCManager` for handling NDEF message detection.
*   `NFCManager+TagWriting.swift`: Extension to `NFCManager` for writing data to NFC tags.
*   `NFCManager+Utilities.swift`: Extension to `NFCManager` for utility methods (UI updates, haptics, etc.).
*   `NFCManagerDelegate.swift`: Defines the `NFCManagerDelegate` protocol.
*   `NFCTagDataType.swift`: Defines the `NFCTagDataType` enum.
*   `NfcTagReaderApp.swift`: The entry point of the application.
*   `TrackedURL.swift`: Defines the `TrackedURL` struct for storing URL tracking information.
*   `URLTracker.swift`: Manages the list of tracked URLs and persists it to `UserDefaults`.

## Dependencies

*   SwiftUI
*   CoreNFC
*   os.log
*   AVFoundation

## Future Enhancements

*   **Support for Additional Data Types:**
    *   Add the ability to write contact information (vCard) or appointment details to NFC tags.
*   **More Advanced Analytics:**
    *   Track location data, time of day, and other metrics to gain deeper insights into tag usage.
*   **User Authentication:**
    *   Implement user accounts to restrict access to NFC writing functionality.
*   **Customizable App Themes:**
    *   Allow users to choose from a variety of color schemes and UI styles.
*   **Cloud Integration:**
    *   Store URL tracking data in the cloud for cross-device synchronization.
*   **Appointment Scheduling:**
    *   Implement a basic appointment scheduling feature directly within the app.

## Known Issues

*   (List any known bugs or limitations here.)

## Contributing

(If you want to encourage contributions, add information on how others can contribute to your project.)

## License

(Add the license type here.)
