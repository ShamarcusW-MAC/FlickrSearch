# FlickrSearch

This is an iOS app that displays a grid of thubmnail images and their information. The app is written in Swift (SwiftUI) and uses the MVVM architecture.

## Project Description 

This shows a grid of images based on the user's search and a few details for each image getting them from the Flickr API.

## Table of Contents

In the structure files contains: Model, Views, ViewModels, Network, Shell and Unit test as well. Tests contains NetworkServiceTests and ViewModelTests with MockJSON files and its data.


# Installation
Can be used with Xcode 14 and above. Compatible with iPhone and iPad with minimum iOS version 16.2.

# Framework
SwiftUI
Combine

# Architecture
This application uses MVVM for the views and clean architecture for the API calls.

# Design Patterns
Async await.

# Testing
Units tests for success and failure situations. Mocked responses using FakeFlickrService

# Screenshots


|List of Images View|

<img width="311" alt="Screenshot 2025-02-10 at 5 46 26 PM" src="https://github.com/user-attachments/assets/da80a01f-9787-44bc-ba87-e6c46b884643" />

|Flickr Image Detail View|

<img width="310" alt="Screenshot 2025-02-10 at 5 46 44 PM" src="https://github.com/user-attachments/assets/22c0fb5c-e380-4764-8cac-602ab00cd7fa" />


