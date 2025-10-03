# Mega App - Flutter Airbnb Unit Management

🏠 A Flutter application for managing Airbnb units with advanced filtering and direct integration with Airbnb services.

## Features

### 🎯 Core Functionality
- **Unit Listing**: Display all available units from JSON data
- **Tag Filtering**: Filter units by tags using an intuitive dropdown
- **Dynamic Counter**: Real-time unit count in the app title
- **Responsive Design**: Optimized for mobile and web platforms

### 🔗 Airbnb Integration
- **Calendar Access**: Direct link to Airbnb multi-calendar for each unit
- **Messages**: Quick access to hosting messages inbox
- **External Links**: Seamless integration with Airbnb platform

### 🎨 User Interface
- **Material Design 3**: Modern and clean interface
- **Orange Theme**: Vibrant and professional color scheme
- **Interactive Cards**: Beautiful unit cards with all essential information
- **Filter Dropdown**: Compact filtering system in the app bar
- **Loading States**: Proper loading and error handling

## Screenshots

### Main Interface
- Clean list of units with filtering capabilities
- Each unit shows title, codes, tags, and action buttons
- Responsive design that works on different screen sizes

### Key Components
- **Unit Cards**: Display unit information with calendar and message buttons
- **Filter Dropdown**: Tag-based filtering with visual indicators
- **Dynamic Title**: Shows total unit count

## Technical Stack

### Dependencies
- **Flutter SDK**: ^3.9.2
- **Material Design 3**: Modern UI components
- **url_launcher**: ^6.2.2 - For opening external Airbnb links
- **cupertino_icons**: ^1.0.8 - iOS-style icons

### Architecture
- **Model-View-Service**: Clean separation of concerns
- **Stateful Widgets**: Reactive UI with proper state management
- **JSON Serialization**: Type-safe data handling
- **Async Operations**: Proper loading and error states

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── unit.dart               # Unit data model
├── services/
│   └── units_service.dart      # Data loading and filtering
├── screens/
│   └── units_list_screen.dart  # Main screen
├── widgets/
│   ├── unit_card.dart          # Unit card component
│   └── filter_dropdown.dart    # Filter dropdown component
└── data/
    └── units.json              # Unit data
```

## Getting Started

### Prerequisites
- Flutter SDK (^3.9.2)
- Dart SDK
- IDE (VS Code, Android Studio, or similar)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ErykAzevedo/mega-app-flutter.git
   cd mega-app-flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For web
   flutter run -d chrome
   
   # For mobile (with device/emulator connected)
   flutter run
   
   # For web server (development)
   flutter run -d web-server --web-port 8080
   ```

### Configuration

The app loads unit data from `lib/data/units.json`. To add or modify units:

1. Edit the JSON file with your unit information
2. Each unit should have:
   - `unitCode`: Unique identifier
   - `unitTitle`: Display name
   - `unitAirbnbCode`: Airbnb listing ID
   - `tags`: Array of filter tags

```json
{
  "unitCode": "example",
  "unitTitle": "Beautiful Apartment",
  "unitAirbnbCode": 123456789,
  "tags": ["city-center", "beach-nearby"]
}
```

## Features in Detail

### Unit Management
- Load units from JSON configuration
- Display comprehensive unit information
- Real-time filtering capabilities
- Error handling with retry options

### Airbnb Integration
- **Calendar Button**: Opens `https://www.airbnb.com.br/multicalendar/{unitAirbnbCode}`
- **Messages Button**: Opens `https://www.airbnb.com.br/hosting/messages/?inbox_type=hosting&stay_listing_ids={unitAirbnbCode}`
- External link handling with proper validation

### Filtering System
- Dropdown-based tag filtering
- Multiple tag selection
- Visual indicators for active filters
- Clear filters functionality
- Real-time results update

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is private and proprietary.

## Contact

**Eryk Azevedo**  
Email: eryk.azevedo@gmail.com  
GitHub: [@ErykAzevedo](https://github.com/ErykAzevedo)

---

🚀 Built with Flutter and ❤️ for efficient Airbnb unit management!