# WikiPlaces App

## Overview

This app was built as an assignment for the Senior iOS position at ABN Amro. The app was designed to request a list of places, search for a specific location and/or input a custom place as desired. It should also allow users to open the Wikipedia app by tapping or entering a location.

## Features

- Fetch a list of places from a specific API
- Display a list of places and its coordinates
- Open said places in the Wikipedia app
- Enter or search for a location with validation

## How to start

1. **Clone the repository:**
   ```git clone https://github.com/paulosytac/WikiPlaces```

2. **Open the project file**
   Open `Places.xcodeproj` in Xcode.

3. **Resolve dependencies**
   If XCode does not resolve dependencies automatically, Run `Resolve Package Versions`.

4. **Build and Run:**
   Select the target `Places` and run the app.
   
## Usage

1. **Display Places**
   The app will request places from API and display a list.

2. **Open Place in Wikipedia**
   Simply tap on any item to open the Wikipedia.

3. **Enter Custom Place**
   Navigate to the custom location view, enter a name (optional), and coordinates (latitude and longitude), then tap "Open" to view the location in the Wikipedia app.

## Future Improvements

- Move URL string to a safer configuration (xcconfig is a good candidate)
- Snapshot Testing
- Localization (English, Dutch)
- Routing capabilities to allow for more features
- Dependency Injection using Actors - **The app at the moment does not use any implementation to support DI due to the scope of current feature list**

## License

This project is licensed under the MIT License.
