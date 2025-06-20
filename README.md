# 📰 Gander - Fact-Check News with SwiftUI

📽️ [Watch Demo Video](https://drive.google.com/file/d/1ceWR2IwA8giTdS9KSyBJ7iF0jQOx1-Mf/view?usp=sharing)



**Gander** is a SwiftUI-powered mobile application that allows users to verify New York Times articles using AI-powered fact-checking. Designed with clean architecture, a modular structure, and testability in mind, the app is focused on simplicity, usability, and accuracy.

---

## 📱 Features

- ✅ Paste any public NYTimes article URL
- 🤖 AI Agent validates the article: `VERIFIED`, `UNVERIFIED`, or `MISINTERPRETATION`
- 💬 Shows rationale and cited sources
- 🏷️ Filtered history based on fact-check status
- 🧾 Detail views with clean typography and UI
- 🧪 100% Unit Test Coverage on Core Logic
- 🌙 Light & Dark Mode support
- 💾 Article history persisted locally
- 📤 Share fact-check results

---

## 🧠 Architecture

- **SwiftUI**: Modern declarative UI
- **MVVM**: Clear separation of concerns
- **CodableAppStorage**: For persisting local state
- **Custom ViewModifiers**: Reusable navigation and styling
- **BottomPopup**: Modal presentation system
- **SwiftSoup**: HTML scraping and content extraction
- **Testing Framework**: Using `Testing` for lightweight async unit tests

---

## 🛠️ Tech Stack

| Layer          | Technology         |
|----------------|--------------------|
| UI             | SwiftUI            |
| Network        | Alamofire          |
| Parsing        | SwiftSoup          |
| Testing        | Testing framework (async tests) |
| Design         | Figma (reference)  |

---

## 🚀 Getting Started

### Prerequisites

- Xcode 15+
- Swift 5.9+
- macOS Sonoma or later
