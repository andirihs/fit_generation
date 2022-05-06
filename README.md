# fit_generation

POC for fit-generation

## Table of content
- [Table of content](#table-of-content)
- [Project Description](#project-description)
- [Getting started](#getting-started)
- [Assets](#assets)
- [Localization](#localization)

## Project Description
This app acts as POC to show how to implement: 
- BottomAppBar using go_router
- Auth using magic Link
- Chat using Stream
- Easy weight tracker with graph

## Getting Started

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Navigation
Open issues: 
[Support multiple navigation stacks](https://github.com/flutter/flutter/issues/99126)
[Preserve the state of routes](https://github.com/flutter/flutter/issues/99124)

As log as these issues are open, ButtonNavBar with GoRouter is **not ready** for the final 
Fit-Generation app, as there are many sub-locations which should be persisted after navigation.
Solution would be to have just one page with stacked views in int. See: 
- https://www.youtube.com/watch?v=xoKqQjSDZ60
- https://codewithandrea.com/articles/multiple-navigators-bottom-navigation-bar/

To make BottomNavigationBar working with go router we need at least two things: 
1. [SharedScaffold](lib/src/shared_scaffold.dart): 
   The SharedScaffold contain a Scaffold-Widget which contains only the widgets which should be 
   present trough all top Screens which could be accessed trough the BottomNavigationBar. 
   This is especially the BottomNavigationBar but could also be a Drawer or an AppBar.  
   In the BottomNavigationBar's ``onTap`` methode must ensure that a new index cause a navigation. 
   Make sure that the index and navigation match the ``BottomNavigationBarItem``.
  
2. [GoRouter](lib/src/routing/app_router.dart)
   The main routes should not have transition to make it look at you would stay on the same page.  
   Further we need the `navigatorBuilder` which ensure that the SharedScaffold get the 
   correct page index when navigating to one of top views.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
