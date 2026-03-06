# Pinterest Clone Mobile App (Flutter)

## Project Goal

Build a **pixel-accurate Pinterest-style mobile application using Flutter** that closely replicates the official Pinterest app.

The objective is to demonstrate:

- Flutter UI expertise
- Clean architecture implementation
- Proper state management
- Efficient image loading
- Smooth scrolling performance
- Attention to micro-interactions and UI detail

This project prioritizes **UI precision, code quality, and performance**.

---

# Reference Application

Study the official Pinterest app before implementation.

iOS  
https://apps.apple.com/app/pinterest/id429047995

Android  
https://play.google.com/store/apps/details?id=com.pinterest

Important:
Every animation, padding, interaction, and layout behavior should be analyzed.

---

# Core Functional Requirements

## 1. Home Feed (Pinterest Masonry Grid)

The main screen must show a **Pinterest-style masonry grid** containing images fetched from the API.

Requirements:

- Staggered grid layout
- Variable image heights
- Smooth infinite scrolling
- Lazy loading
- Image caching
- Grid spacing similar to Pinterest
- Efficient memory usage

Implementation package: flutter_staggered_grid_view


---

## 2. Pin Detail Screen

When a user taps on a pin, the application should navigate to a **detail view**.

Required features:

- Hero animation from grid image
- Full image preview
- Smooth transition
- Optional metadata display

Behavior:

- Image expands from grid position
- Back navigation restores previous scroll state

---

## 3. Search Feature

The application should support searching for images.

API endpoint example: GET /search?query=nature


Features:

- Search input field
- Display results in masonry grid
- Debounced queries
- Loading indicator

---

## 4. Loading States

While images or API data are loading:

- Show skeleton UI placeholders
- Use shimmer loading effect

Package: shimmer


---

## 5. Image Caching

Images must be cached locally to prevent repeated network requests and improve performance.

Package: cached_network_image


---

## 6. Authentication

Authentication should be implemented using Clerk.

Package: clerk_flutter


Basic requirements:

- User sign in
- User session management
- Auth state awareness

Full authentication UI customization is optional.

---

# Required Technology Stack

These packages **must be used**.

| Category | Package |
|--------|--------|
State Management | flutter_riverpod
Navigation | go_router
Networking | dio
Image Caching | cached_network_image
Loading Effects | shimmer
Grid Layout | flutter_staggered_grid_view
Authentication | clerk_flutter

---

# API Source

Images must be retrieved from **Pexels API**.

API documentation:
https://www.pexels.com/api/

Alternative API (optional):
https://unsplash.com/developers

Example endpoint: https://api.pexels.com/v1/curated

Authentication header: YOUR_API_KEY


---

# Application Architecture

The application must follow **Clean Architecture principles**.

Architecture layers:

Presentation Layer
Domain Layer
Data Layer


---

## Presentation Layer

Responsible for:

- UI components
- Screens
- Riverpod providers
- State handling
- User interaction

Components: pages, widgets, controllers, providers


---

## Domain Layer

Contains business logic.

Responsibilities:

- Use cases
- Business rules
- Entities
- Repository interfaces

Components: Entities ,UseCases,Repository Interfaces


---

## Data Layer

Handles external data sources.

Responsibilities:

- API communication
- Data mapping
- Repository implementations

Components: API Services,DTO Models,Repository Implementations,Data Sources



---

# Suggested Folder Structure

lib/

core/
network/
services/
utils/

features/

auth/
data/
domain/
presentation/

home/
data/
models/
repositories/
datasources/
domain/
entities/
repositories/
usecases/
presentation/
pages/
widgets/
providers/

search/
data/
domain/
presentation/

router/
app_router.dart

main.dart



---

# State Management

State must be handled using **Riverpod**.

Types of providers to use: Provider
StateNotifierProvider
FutureProvider



Responsibilities:

- Dependency injection
- State management
- API state handling
- UI updates

---

# Navigation

Navigation must use: go_router



---

# Performance Requirements

The application must provide a **smooth user experience**.

Performance expectations:

- Smooth scrolling
- No frame drops
- Efficient image loading
- Lazy image rendering
- Avoid unnecessary widget rebuilds

Optimization techniques:

- const constructors
- pagination
- caching
- efficient providers

---

# UI Accuracy Requirements

The UI should match Pinterest as closely as possible.

Critical aspects:

- Padding
- Card radius
- Shadow elevation
- Grid spacing
- Animation curves
- Font sizes
- Image aspect ratios

Pixel-level accuracy is expected.

---

# Micro-Interactions

These interactions improve polish and user experience.

Examples:

- Hero transition on pin tap
- Image fade-in when loaded
- Pull-to-refresh behavior
- Smooth scrolling
- Scroll position memory when switching tabs
- Loading shimmer animations

Attention to detail is highly valued.

---

# Error Handling

Application must handle:

- Network errors
- API failures
- Empty states
- Loading states

Display user friendly UI when errors occur.

---

# Pagination

Home feed should support **infinite scroll pagination**.

Behavior:

- Load additional images when nearing bottom
- Prevent duplicate API requests
- Maintain scroll state

---

# GitHub Requirements

The project must be submitted via **public GitHub repository**.

Requirements:

- Clean commit history
- Meaningful commit messages


---

# Evaluation Criteria

| Criteria | Weight |
|--------|--------|
UI Accuracy | 35%
Architecture | 25%
Code Quality | 20%
Performance | 20%

---

# Optional Enhancements

These are **not required but beneficial**.

Possible improvements:

- dark mode
- video pins
- saved pins feature
- animated grid transitions
- offline cache
- advanced search filters

---

# Non-Goals

The following are **not required**:

- full Pinterest backend
- social features
- messaging
- comments
- notifications
- advanced profile system

---

# Development Philosophy

The project focuses on:

- UI craftsmanship
- architecture discipline
- performance optimization
- micro-interaction polish

The goal is to demonstrate **professional Flutter engineering capability**.

---

# Summary

This project requires building a **high-quality Pinterest clone** using modern Flutter development practices.

Key highlights:

- Clean architecture
- Riverpod state management
- GoRouter navigation
- Pexels API integration
- Masonry grid layout
- Image caching
- Micro-interaction polish