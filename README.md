# TMDB

TMDB is an iOS app developed using SwiftUI and Swift. It utilizes The Movie Database (TMDB) API to display trending movies and details about individual movies. The app showcases native development capabilities without relying on third-party libraries for core functionalities.

## Features

- Browse trending movies
- View detailed information about each movie
- Async/Await for network requests
- SwiftUI for the user interface
- MVVM architecture
- Pagination to browse through movie lists efficiently (aka. infinit scrolling, as long as the API returns data, user can scroll)
- Search functionality allowing users to find movies by title

## SwiftLint Integration

To ensure code quality and maintainability, SwiftLint has been integrated into the project. SwiftLint helps enforce Swift style and conventions, making the code cleaner and more consistent. This step demonstrates a commitment to best coding practices.

## Code Structure

The project is organized into several key directories:

- `Models`: Contains the data models used in the app.
- `Views`: Contains the SwiftUI views for displaying the UI.
- `ViewModels`: Contains the view models providing the logic for the views.
- `Services`: Contains network services for fetching data from the TMDB API, demonstrating how to handle network requests natively.

## Native Development Approach

This project is developed entirely with native tools and libraries, showcasing the ability to implement functionalities without third-party dependencies. For instance:

- **Image Loading**: Implemented natively instead of using libraries like SDWebImage or Kingfisher.
- **List Pagination and Search**: Custom implementations showcase handling these functionalities without relying on libraries like Alamofire for network requests or SwiftyJSON for JSON parsing.
- **Unit Testing**: XCTest is used for unit testing to demonstrate testing capabilities without third-party frameworks like Quick/Nimble.

## Unit Testing

The project includes a suite of unit tests to ensure the reliability of critical functionalities. While the test coverage is not exhaustive due to the project's scope and time constraints, it highlights key areas such as network service calls, view model behavior, and the search functionality.

## Requirements

- iOS 17.2
- Xcode 15.2
- Swift 5

## Installation

Clone the repository:

```bash
git clone git@github.com:kihab/tmdb.git
```
Navigate to the project directory:
```
cd TMDB
```
Open the project in Xcode:
```
open TMDB.xcodeproj
```

## App Screenshot

![Simulator Screenshot - iPhone 15 Pro - 2024-02-18 at 15 14 59](https://github.com/kihab/tmdb/assets/3265304/ebe7a715-d324-4258-940f-9caad019e320) ![Simulator Screenshot - iPhone 15 Pro - 2024-02-18 at 15 15 13](https://github.com/kihab/tmdb/assets/3265304/fa85c37b-c5f1-42c7-a498-4f1f40ecdcd8) ![Simulator Screenshot - iPhone 15 Pro - 2024-02-18 at 15 15 34](https://github.com/kihab/tmdb/assets/3265304/7d552d76-14e7-44d3-8754-d393f2da8987)




