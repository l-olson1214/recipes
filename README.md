# Recipes

## Overview

Recipes is an iOS app that allows users to discover a variety of desserts, view details about each dessert, and favorite their favorite desserts for future reference.

## Features

- **Browse Desserts**: Users can browse through a list of delicious desserts.
- **View Dessert Details**: Users can view detailed information about each dessert, including its name, image, and ingredients, as well as how to make it.
- **Favorite Desserts**: Users can mark desserts as favorites to easily access them later.
- **Search Functionality**: Users can search for specific desserts by name.
- **Core Data Integration**: Favorites are stored locally using Core Data, ensuring that they persist across app launches.

## Architecture

Recipes follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Model**: Represents dessert data and business logic, including fetching desserts from a remote server. This lives in the Networking Layer. 
- **View**: Displays user interface elements, including lists of desserts and detailed dessert information.
- **ViewModel**: Mediates between the Model and the View, handling data retrieval and preparation for display.

## Requirements

- iOS 14.0+
- Xcode 12.0+

## Installation

1. Clone the repository:
     git clone https://github.com/l-olson1214/recipes
2. Open the project in Xcode:
     cd Recipes
     open Recipes.xcodeproj
3. Build and run the project using the simulator or your connected iOS device (or a simulator)

## Usage

1. Upon launching the app, users will be presented with a list of desserts.
2. Tap on a dessert to view its details.
3. To favorite a dessert, tap the heart icon.
4. To unfavorite a dessert, tap the filled heart icon.
5. To view all favorites, navigate using the heart icon in the upper right hand corner of the screen with "Favorites", you can view the details of each favorited dessert.
6. To navigate back to home, simply click the home icon in the upper right hand corner of the screen with "Home"
7. Use the search bar to find specific desserts by name, in either home page or favorites page.

## Acknowledgements

- The dessert data used in this app is sourced from https://themealdb.com/api.php

