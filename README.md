# Airlines-Application  

## Overview  
Airlines-Application is a Master-Details app designed to help users explore and manage airline information. The app allows users to browse all airlines, search for specific ones, view detailed information, and add new airlines to the list.  

## Features  

### App Features  
- **View All Airlines**: Browse a list of all available airlines.  
- **Search for Airlines**: Search airlines by name with results updating dynamically as you type.  
- **Airline Details**:  
  - View detailed information about an airline, including:  
    - Name  
    - Country  
    - Slogan  
    - Headquarters  
    - Website link  
- **Add New Airlines**:  
  - Use a form to add a new airline with details like:  
    - Name  
    - Country  
    - Slogan  
    - Headquarters  
    - Website URL  

## Technical Details  

### Architecture  
- **MVVM with Clean Architecture**: Ensures a modular and maintainable codebase.  

### Reactive Programming  
- **RxSwift**: Handles data binding and reactive updates for a seamless user experience.  

### Design Principles  
- **Protocol-Oriented Programming (POP)**: Enhances flexibility, modularity, and testability.  

### Data Management  
- **Core Data**: Efficiently handles local data storage.  

### Networking  
- **API Integration**: Fetches dynamic data from external sources. *(Currently, API integration is under development and not fully functional.)*  

### UI Framework  
- **UIKit**: Built with Apple’s UIKit framework to deliver a smooth and responsive user interface.  

### Unit Testing  
- Includes unit tests to ensure app reliability and maintain quality standards.  

## Installation  

1. Open Xcode.  
2. Select **Clone Git Repository**.  
3. Enter the repository URL:  
   ```bash
   https://github.com/HendEl-Mahdy/Airlines-Application-.git

## Note
The project currently uses mocked data to fetch airline information while API functionality is being developed.
