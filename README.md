# BuzZapp 🍔

BuzZapp is a modern food delivery iOS application built with SwiftUI.

The app focuses on a complete food ordering experience with restaurant discovery, food browsing, search, cart management, checkout, order history and festival-based recommendations.

The project also explores modern Apple platform technologies such as SwiftData and App Intents, including Siri integration inspired by the latest developer technologies introduced at WWDC26.

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
- Restaurant details and menu
- Add and remove food items from cart
- Quantity management
- Local cart persistence using SwiftData
- Checkout flow
- Order history
- User profile
- Festival-based recommendations
- REST API integration
- Local food and restaurant images
- Siri integration using App Intents
- Open BuzZapp using Siri
- Check cart contents using Siri
- Siri response with product names, quantities and total amount

## 🗣️ Siri & App Intents

BuzZapp uses Apple's App Intents framework to expose app actions to Siri and make common app interactions accessible through voice commands.

The integration was built while exploring the latest Apple platform direction around App Intents and Siri introduced at WWDC26.

Currently supported:

- Open BuzZapp using Siri
- Show the current cart using Siri
- Read product names and quantities
- Calculate and read the cart total

Example:

> "Show my cart in BuzZapp"

Siri responds with the products, quantities and total amount in the cart.

The App Intents layer is designed so that more food ordering actions can be exposed through Siri as the project evolves.

## 💾 SwiftData Cart Persistence

BuzZapp uses SwiftData to persist the local cart.

The cart stores only the information required to maintain the user's selections:

```text
foodID
quantity
