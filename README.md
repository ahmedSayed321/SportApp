# Remontada — Multi-Sport iOS App

A native iOS sports app that lets users browse leagues, teams, players, and match fixtures across multiple sports — built with Swift using the **MVP** architectural pattern.

---

## 📱 Features
- **Multi-sport support** — Football, Basketball, Cricket, and Tennis
- **Onboarding screen** — Smooth page-based onboarding experience on first launch
- **Leagues browser** — Browse leagues per sport with logo and country information
- **League fixtures** — View upcoming and past match fixtures with date-range filtering
- **Teams & Players** — Explore team rosters and detailed player statistics
- **Favourites** — Save favourite leagues locally using Core Data for offline access
- **Offline support** — Cached favourite leagues displayed when there is no internet connection
- **Network monitoring** — Real-time connectivity detection via `NetworkMonitor`
- **Dark / Light mode** — Toggle theme from the Settings screen, persisted across launches
- **Bilingual (EN / AR)** — Full Arabic and English localization with proper RTL layout support, applied instantly without an app restart

---

## 📸 Screenshots

| | | |
|:---:|:---:|:---:|
| <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.01.52.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.02.03.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.02.06.png" width="250"> |
| <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.02.10.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.03.31.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.03.39.png" width="250"> |
| <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.03.49.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.04.30.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.05.05.png" width="250"> |
| <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.05.11.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.05.13.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.05.15.png" width="250"> |
| <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.05.17.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.05.26.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.05.37.png" width="250"> |
| <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.05.50.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.06.00.png" width="250"> | <img src="SportApp/Screens/Simulator Screenshot - iPhone 16 - 2026-06-08 at 17.06.11.png" width="250"> |

---

## 🏗️ Architecture

The app follows the **MVP (Model–View–Presenter)** pattern:

```
View  ──▶  Presenter  ──▶  NetworkServicesProtocol
  ▲              │
  └──────────────┘
```

- **Model** — `Codable` structs (`League`, `Team`, `Player`, `LeagueEventsResponse`, `SportType`, etc.)
- **View** — UIKit `UIViewController`s and Storyboard XIBs; passive, delegates all logic to the Presenter
- **Presenter** — Holds all business logic, calls `NetworkServicesProtocol`, updates the View via protocol callbacks
- **NetworkServices** — Protocol-based (`NetworkServicesProtocol`), making the networking layer fully mockable for unit testing

---

## 🗂️ Project Structure

```
Remontada-App/
├── SportApp/
│   ├── Model/
│   │   ├── Entites/
│   │   │   ├── SportType.swift             # Enum for Football, Basketball, Cricket, Tennis
│   │   │   ├── Leagues/
│   │   │   │   ├── LeagueResponse.swift
│   │   │   │   └── LeagueEvents.swift
│   │   │   ├── Teams/
│   │   │   │   └── Team.swift
│   │   │   └── Players/
│   │   │       └── Player.swift
│   │   └── Services/
│   │       ├── remote/
│   │       │   └── NetworkServices.swift   # Protocol + Alamofire implementation
│   │       └── local/
│   │           ├── LocalDataSource.swift   # Core Data CRUD for favourites
│   │           └── LocalDataSoucreProtocol.swift
│   ├── Modules/
│   │   ├── Splash/
│   │   ├── Onborading/                     # Page-based onboarding with custom XIB
│   │   ├── Home/
│   │   │   ├── presenter/
│   │   │   └── view/
│   │   ├── Leagues/
│   │   │   ├── presenter/
│   │   │   └── view/
│   │   ├── LeagueDetails/
│   │   │   ├── presenter/
│   │   │   └── view/
│   │   ├── TeamDetails/
│   │   │   ├── presenter/
│   │   │   └── view/
│   │   ├── Favourite/
│   │   │   ├── presenter/
│   │   │   └── view/
│   │   └── Settings/
│   │       ├── presenter/
│   │       └── view/
│   ├── Utils/
│   │   ├── network/
│   │   │   └── NetworkMonitor.swift        # Real-time connectivity monitoring
│   │   ├── localication/
│   │   │   ├── LanguageManager.swift       # RTL/LTR switching & UserDefaults persistence
│   │   │   └── Localizable.xcstrings
│   │   └── view/
│   ├── View/                               # Shared storyboard & XIB resources
│   ├── Resources/
│   ├── Screens/                            # App screenshots
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
└── SportAppTests/
    ├── MockNetworkServices.swift
    ├── NetworkServicesTests.swift
    └── SportAppAPITests.swift
```

---

## 🌐 Networking

- All network calls go through the `NetworkServicesProtocol` — a clean abstraction over [Alamofire](https://github.com/Alamofire/Alamofire)
- `NetworkServices` is a singleton (`NetworkServices.instance`) with an injectable `Session` for testability
- Supports fetching: **Leagues**, **Fixtures** (with date-range & timezone), **Teams**, and **Players**
- Responses are decoded via `Codable` structs; failures gracefully return empty arrays

---

## 💾 Core Data

Favourite leagues are persisted locally using **Core Data** (`LocalDataSource`), allowing them to be displayed even when the device is offline. The `LocalDataSoucreProtocol` keeps the storage layer mockable and decoupled from presenters.

---

## 🧪 Unit Tests

The test suite uses a `MockNetworkService` that fully conforms to `NetworkServicesProtocol`, enabling isolated, deterministic tests with zero real network calls.

| Method | Tests |
|---|---|
| `getLeagueData` | called with correct sport · success · empty data |
| `getLeagueEventsData` | called with correct params (sport, leagueId, from, to, timezone) · success · error |
| `getTeams` | called with correct leagueId & sport · success · empty data |
| `getPlayers` | called with correct teamId & sport · success · empty data |

Run tests with **`Cmd + U`** in Xcode.

---

## 🌍 Localization

The app supports **English** and **Arabic** with full RTL layout switching at runtime without requiring an app restart.

- Language preference is persisted in `UserDefaults` via `LanguageManager`
- The entire UI — Navigation Bar, Tab Bar, Collection Views — flips direction immediately on change
- Strings are managed with an `.xcstrings` catalog for clean multi-language support

---

## 🎨 Theme

Dark and Light mode can be toggled from the **Settings** screen. The selected theme is saved to `UserDefaults` and restored on every launch via `SceneDelegate`.

---

## ⚙️ Requirements

| | |
|---|---|
| Platform | iOS 16.0+ |
| Language | Swift 5 |
| IDE | Xcode 15+ |
| Networking | [Alamofire](https://github.com/Alamofire/Alamofire) |
| API | [AllSportsAPI](https://apiv2.allsportsapi.com) |

---

## 👥 Contributors
- JETSMobileLabMini8 team

---

## 📄 License
This project is for educational purposes. All rights reserved © 2026.
