# BuzZapp 🍔

BuzZapp is a modern food delivery iOS application built with SwiftUI.

It includes restaurant discovery, food browsing, search, cart management, checkout, order history and festival-based recommendations.

## 📱 Screenshots

<table>
<tr>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.31.16.png" width="180"></td>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.35.51.png" width="180"></td>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.36.17.png" width="180"></td>
</tr>

<tr>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.36.25.png" width="180"></td>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.36.56.png" width="180"></td>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.37.16.png" width="180"></td>
</tr>

<tr>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.38.19.png" width="180"></td>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.38.23.png" width="180"></td>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.38.27.png" width="180"></td>
</tr>

<tr>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.38.53.png" width="180"></td>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.39.28.png" width="180"></td>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.41.22.png" width="180"></td>
</tr>

<tr>
<td><img src="BuzZapp/Screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20-%202026-09-30%20at%2013.41.27.png" width="180"></td>
<td></td>
<td></td>
</tr>
</table>

## ✨ Features

- Restaurant discovery
- Food category browsing
- Search for restaurants and food
- Restaurant detail and menu
- Add and remove food items from cart
- Quantity management
- Checkout flow
- Order history
- User profile
- Festival-based recommendations
- REST API integration
- Local food and restaurant images

## 🛠 Tech Stack

- Swift
- SwiftUI
- MVVM
- Async/Await
- URLSession
- REST API
- Codable
- Xcode
- Git & GitHub

## 🌐 API Integration

BuzZapp fetches restaurant, food, category, order, user and festival data using REST APIs with URLSession and Swift Concurrency.

Festival data is also used to identify the current festival and show relevant restaurant recommendations.

## 🧠 Recommendation System

Restaurants are scored using:

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