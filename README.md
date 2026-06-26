# AIRA — Mental Health iOS App

**AIRA** is a mental health iOS app built with SwiftUI and the MVVM architecture.

## Features

- Animated onboarding with video (AVKit) and smooth transitions
- Mood tracker with persistent user preferences via UserDefaults
- AI chatbot for personalized mental health support
- Breathing exercise with guided video

## Tech Stack

- **Framework:** SwiftUI
- **Architecture:** MVVM
- **Media:** AVKit
- **Storage:** UserDefaults
- **Target:** iOS 18.2+

## Project Structure

```
AIRA/
├── App/                    # App entry point
├── Onboarding/             # Splash, Welcome, Mood, Goal, Breathing
├── Components/             # Reusable UI components
├── Services/               # UserPreferences, VideoPlayer
├── Constants/              # Colors, Fonts
├── Extensions/             # Color helpers
└── Assets.xcassets/        # Images, videos
```

## Getting Started

1. Clone the repo
2. Open `AIRA.xcodeproj` in Xcode 16+
3. Build and run on iOS 18.2+ simulator or device

## License

This project is for educational/demonstration purposes.
