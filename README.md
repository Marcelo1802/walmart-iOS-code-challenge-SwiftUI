# Walmart iOS Code Challenge - SwiftUI

A modern iOS application built with SwiftUI that displays a list of countries with their details. The app follows Clean Architecture principles and implements the MVVM design pattern.

## Features

- 📱 Display list of countries with name, region, code, and capital
- 🔍 Real-time search filtering by country name or capital
- 🌐 Robust error handling and network requests
- 📱 Support for iPhone and iPad
- 🔄 Support for all device orientations
- 🌓 Light and Dark mode support
- 📏 Dynamic Type support
- 🏗️ Clean Architecture with MVVM pattern

## Technical Stack

| Aspect | Technology |
|--------|------------|
| UI Framework | SwiftUI |
| Architecture | Clean Architecture with MVVM |
| Networking | URLSession with async/await |
| JSON Parsing | Codable |
| Dependency Injection | Manual DI |
| Testing | XCTest (Ready for implementation) |

## Project Structure

```
walmart-iOS-code-challenge/
├── Models/
│   └── Country.swift
├── Views/
│   └── CountryListView.swift
├── ViewModels/
│   └── CountryViewModel.swift
├── Services/
│   └── CountryService.swift
└── walmart_iOS_code_challengeApp.swift
```

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

1. Clone the repository
2. Open `walmart-iOS-code-challenge.xcodeproj` in Xcode
3. Build and run the project

## Architecture Overview

### Clean Architecture
The project follows Clean Architecture principles with clear separation of concerns:

- **Models**: Data structures and business logic
- **Views**: UI components and presentation logic
- **ViewModels**: Business logic and state management
- **Services**: Data fetching and external communication

### MVVM Pattern
- **Model**: `Country` - Represents the country data structure
- **View**: `CountryListView` - Handles UI presentation and user interaction
- **ViewModel**: `CountryViewModel` - Manages data and business logic

## Features Implementation

### Country List
- Displays countries in the order they appear in the JSON
- Each country cell shows:
  - Name
  - Region
  - Code
  - Capital

### Search Functionality
- Real-time filtering as user types
- Searches through both country names and capitals
- Case-insensitive search

### Error Handling
- Network error handling
- Data parsing error handling
- User-friendly error messages
- Retry functionality

### UI/UX
- Responsive layout
- Support for all device sizes
- Dynamic Type support
- Dark mode support
- Loading indicators
- Error states with retry options

## API Integration

The app fetches country data from the REST Countries API:
```
https://restcountries.com/v3.1/all
```

## Future Improvements

1. Add unit tests
2. Implement caching
3. Add offline support
4. Add country details view
5. Implement sorting options
6. Add pull-to-refresh functionality
7. Add pagination for large datasets



