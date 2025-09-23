# PromptBolt ⚡

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Latest Release](https://img.shields.io/github/v/release/sakaguchi-0725/PromptBolt)](https://github.com/sakaguchi-0725/PromptBolt/releases)
[![macOS](https://img.shields.io/badge/macOS-14.0+-blue.svg)](https://www.apple.com/macos/)

A powerful macOS menu bar application for managing and quickly accessing your AI prompts with global keyboard shortcuts.

## ✨ Features

- 🖱️ **Menu Bar Integration**: Lives in your menu bar for quick access
- ⌨️ **Global Shortcuts**: Instantly paste prompts with custom keyboard shortcuts
- 📝 **Prompt Management**: Organize your AI prompts with titles and descriptions
- 🔄 **Auto Updates**: Seamless updates using Sparkle framework

## 📸 Screenshots

### Menu Bar View
<img src="Resources/menubar.png" alt="Menu Bar Screenshot" width="200">

### Prompt Management
<img src="Resources/prompt-management.png" alt="Prompt Management Screenshot" width="400">

## 🚀 Installation

### Download from Releases
1. Go to the [Releases page](https://github.com/sakaguchi-0725/PromptBolt/releases)
2. Download the latest `PromptBolt.dmg` file
3. Open the DMG and drag PromptBolt to your Applications folder
4. Launch PromptBolt from Applications or Spotlight

### System Requirements
- macOS 14.0 or later
- Apple Developer ID signed application (notarized)

## 🎯 How to Use

### Creating Your First Prompt
1. Click the PromptBolt icon in your menu bar
2. Select "Dashboard" to open the main interface
3. Navigate to the "Prompts" section
4. Click "New" to create a new prompt
5. Fill in:
   - **Title**: A descriptive name for your prompt
   - **Content**: The actual prompt text that will be copied
   - **Shortcut**: A unique keyboard combination (e.g., Cmd+Shift+A)

### Using Global Shortcuts
1. From anywhere on your Mac, press your configured shortcut key combination
2. PromptBolt automatically copies the prompt to your clipboard
3. Simply press `Cmd+V` to paste the prompt into any application

### Menu Bar Quick Access
- View your 5 most recent prompts directly from the menu bar
- See the assigned keyboard shortcut for each prompt
- Access the dashboard, check for updates, or quit the app

## ⚙️ Settings

### General Settings
- **Launch on Start**: Automatically start PromptBolt when you log in
- **Auto Update Check**: Automatically check for new versions

### Keyboard Shortcuts
- Supports combinations with Command (⌘), Option (⌥), Control (⌃), and Shift (⇧)
- Compatible with letters A-Z and numbers 0-9
- Duplicate shortcuts are automatically prevented

## 🛠️ Development

### Technology Stack
- **Language**: Swift
- **UI Framework**: SwiftUI
- **Data Persistence**: SwiftData
- **Global Shortcuts**: HotKey framework
- **Auto Updates**: Sparkle framework
- **Minimum Target**: macOS 14.0

### Building from Source
```bash
# Clone the repository
git clone https://github.com/sakaguchi-0725/PromptBolt.git
cd PromptBolt

# Open in Xcode
open PromptBolt.xcodeproj

# Build and run (Cmd+R)
```

### Project Structure
```
PromptBolt/
├── Models/                 # Data models (Prompt, ShortcutKey, etc.)
├── Views/                  # SwiftUI views and components
├── Services/               # Core services (ShortcutManager, UpdateService, etc.)
├── Extensions/             # Swift extensions
└── Resources/              # Assets and configuration files
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines
1. Follow Swift coding conventions
2. Write descriptive commit messages
3. Update documentation for new features
4. Test thoroughly on macOS 14.0+

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆔 Code Signing

This application is signed with an Apple Developer ID certificate, ensuring it can run on macOS without security warnings.

## 🔄 Updates

PromptBolt uses Sparkle for automatic updates. When enabled, the app will:
- Check for updates daily
- Notify you when new versions are available
- Handle secure downloads and installations
- Support gentle reminder notifications

## 🐛 Issues & Support

If you encounter any issues or have feature requests:
1. Check the [existing issues](https://github.com/sakaguchi-0725/PromptBolt/issues)
2. Create a new issue with detailed information
3. Include your macOS version and PromptBolt version

## 📧 Contact

- **Author**: Kazuma Sakaguchi
- **GitHub**: [@sakaguchi-0725](https://github.com/sakaguchi-0725)
- **Project**: [PromptBolt Repository](https://github.com/sakaguchi-0725/PromptBolt)

---

⚡ **Made with Swift and ❤️ for the macOS community**