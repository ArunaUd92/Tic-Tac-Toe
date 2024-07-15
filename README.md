
# Tic-Tac-Toe iOS App

This is a simple Tic-Tac-Toe game for iOS built using SwiftUI. The game supports local multiplayer functionality using Multipeer Connectivity, allowing two nearby iPhones to play without an internet connection. The app features a modern, gradient-based UI design.

![](https://github.com/ArunaUd92/Tic-Tac-Toe/blob/main/ScreenRecording2024-07-15at12.42.29am-ezgif.com-video-to-gif-converter.gif)

## Features
- Two-player Tic-Tac-Toe game.
-  Local multiplayer using Multipeer Connectivity (Bluetooth/Wi-Fi)
-  Animated game board and transitions.
- Gradient background and stylish button designs.

## Requirements
- iOS 14.0 or later
- Xcode 12.0 or later
- Swift 5.3 or later

## Installation

Clone the repository:

```bash
  git clone https://github.com/yourusername/tictactoe-ios.git
```

Open the project in Xcode:

```bash
  cd tictactoe-ios
  open TicTacToe.xcodeproj
```

Build and run the project on your iOS device or simulator.

## Usage

#### Host Game:
- Launch the app on the first device.
- Tap on "Host Game" to start hosting a game session.

#### Join Game:
- Launch the app on the second device.
- Tap on "Join Game" to connect to the hosting device.

#### Play Game:
- The game board will appear on both devices once connected.
- Take turns tapping on the empty squares to place your symbol (X or O).
- The game automatically detects a win or a tie and displays a message.
- Tap "Play Again" to reset the board for a new game.

## Project Structure

- TicTacToeApp.swift: The main entry point of the app.
- ContentView.swift: The main game view containing the game logic and UI.
- GameViewModel.swift: The view model managing the game state and logic.
- Coordinator.swift: The class handling Multipeer Connectivity.
- CustomModifiers.swift: Custom SwiftUI view modifiers for styling.
- ColorExtension.swift: Extension to define custom colors.

## Adding More Features
Feel free to extend the functionality by adding features such as:

- Single-player mode with AI.
- Score tracking.
- Enhanced animations and sound effects.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.
