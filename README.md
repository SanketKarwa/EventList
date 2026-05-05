# Event Listing App

## Overview
This is a sample iOS application built using SwiftUI, Combine, and MVVM architecture.  
The app displays a list of events, supports bookmarking, image caching, and offline data handling.

---

## Features

- Event listing with title, location, image  
- Bookmark / Unbookmark events (UserDefaults)  
- Image loading with in-memory caching (NSCache)  
- Disk cache for API responses with TTL  
- Distance calculation from user location  
- Open route in Apple Maps  
- Combine-based async data flow  
- Unit test coverage for repository & storage  

---

## Architecture

- MVVM (Model-View-ViewModel)
- Repository Pattern (single source of truth)

### Layers:
- View (SwiftUI) → UI + Image rendering  
- ViewModel → State management (Combine)  
- Repository → API + Cache + Local storage  
- API Service → Network layer  
- Disk Cache → API response caching (TTL)  
- UserDefaults → Bookmark persistence  
- NSCache → Image caching (UI layer)

---

## 🛠️ Tech Stack

- Swift
- SwiftUI
- Combine
- CoreLocation
- URLSession
- NSCache
- UserDefaults

---

## Run Instructions

### 1. Clone the Repository

git clone https://github.com/SanketKarwa/EventList.git
cd event-app

### 2. Open in Xcode

Open EventApp.xcodeproj

### 3. Select Target

Choose iPhone Simulator (e.g., iPhone 15)

### 4. Run the App

Cmd + R

---

## Data Flow

View → ViewModel → Repository → (Cache / API)

---

## Assumptions

- Event data is lightweight → UserDefaults used  
- Images are large → cached using NSCache  
- API cache uses TTL (5 mins)  
