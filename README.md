# BuzZapp 🍔

BuzZapp is a modern food delivery iOS application built with SwiftUI.

It includes restaurant discovery, food browsing, search, cart management, checkout, order history, festival-based recommendations and API-driven data.

## 📱 Screenshots

### Home & Discovery

![Home](BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.31.16.png)

![Home](BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.35.51.png)

### Restaurant & Food

![Restaurant](BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.36.17.png)

![Food](BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.36.25.png)

### Search & Categories

![Search](BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.36.56.png)

![Categories](BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.37.16.png)

### Cart & Checkout

![Cart](BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.38.19.png)

![Checkout](BuzZapp/Screenshots/Simulator%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.38.23.png)

### Profile & Orders

![Profile](BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.38.27.png)

![Orders](BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.38.53.png)

## ✨ Features

- Restaurant discovery
- Food category browsing
- Search for restaurants and food
- Restaurant detail and menu
- Add/remove food items from cart
- Quantity management
- Checkout flow
- Order history
- User profile
- Festival-based food recommendations
- Dynamic API data
- Local food and restaurant images
- Responsive SwiftUI interface

## 🛠 Tech Stack

- Swift
- SwiftUI
- MVVM
- Async/Await
- URLSession
- REST API
- JSON / Codable
- Xcode
- Git & GitHub

## 🌐 API Integration

BuzZapp fetches restaurant, food, category, order, user and festival data from REST APIs using `URLSession` and Swift Concurrency.

The app also integrates festival data to identify the current festival and show relevant restaurant recommendations.

## 🧠 Recommendation System

Restaurants are scored using factors such as:

- Rating
- Popularity
- Distance
- Festival relevance

The highest-scoring restaurants are shown as recommendations.

## 🏗 Architecture

The project follows an MVVM-based structure:

```text
BuzZapp
├── App
├── Models
├── Services
├── ViewModels
├── Views
├── Components
├── Algorithms
└── Resources