# fit_generation

POC for fit-generation

## Table of content

- [Table of content](#table-of-content)
- [Project Description](#project-description)
- [Getting started](#getting-started)
- [Navigation](#navigation) 
- [Assets](#assets)
- [Localization](#localization)
- [Firebase](#firebase)
   - [Firebase UI](#flutterfireui)
   - [Firebase Auth](#firebase-auth)

## Project Description

This app acts as POC to show how to implement:

- BottomAppBar using go_router
- Auth using magic Link
- Chat using Stream
- Easy weight tracker with graph

## Getting Started

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials, samples, guidance on
mobile development, and a full API reference.

## Navigation

Navigation 2 is done with goRouter. See the [docs](https://gorouter.dev/)
and [Repo with Samples](https://github.com/flutter/packages/tree/main/packages/go_router/example/lib)
.  
BottomNavBar is done according
to [shared_scaffold sample code](https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/shared_scaffold.dart)

Open GoRouter issues:

- [Support multiple navigation stacks](https://github.com/flutter/flutter/issues/99126)
- [Preserve the state of routes](https://github.com/flutter/flutter/issues/99124)

As log as these issues are open, ButtonNavBar with GoRouter could **not** persist view state and
sub-locations after navigation.  
A solution would be to have just one page with stacked views in it:

- [Basic BottomNavBar Video with stacked Views](https://www.youtube.com/watch?v=xoKqQjSDZ60)
- [Holding BottomNavBar Sub-Navigation State](https://codewithandrea.com/articles/multiple-navigators-bottom-navigation-bar)
- [Nested Navigation using GoRouter](https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/nested_nav.dart)

To make BottomNavigationBar working with go router we need at least three things:

1. [SharedScaffold](lib/src/shared_scaffold.dart):
   The SharedScaffold contain a Scaffold-Widget which contains only the widgets which should be
   present trough all top views which could be accessed trough the BottomNavigationBar. This is
   especially the BottomNavigationBar but could also be a Nav-Drawer or an global AppBar.  
   In the BottomNavigationBar's ``onTap`` methode must ensure that a new index cause a navigation.
   Make sure that the index and navigation match the ``BottomNavigationBarItem``.

2. [GoRouter](lib/src/routing/app_router.dart)
   The top-routes should not have transition to make it look at you would stay on the same page.  
   Further we need the ``navigatorBuilder`` which ensure that the SharedScaffold get the correct
   page index when navigating to one of top views. Make sure that the index provided
   by ``getSelectedNavBarIndex()`` match the BottomNavigationBar.

3. When navigating to a route which is **not a sub-route** of the top views (in
   BottomNavigationBar)  
   the ``navigatorBuilder`` will provide -1 to the to the SharedScaffold which then hide the
   BottomNavBar.  
   This way there is no nav-stack when restoring the app state (no back button) and  
   we therefore **must add a possibility to return home manually**.

ButtonNavBar Style:
Until now, normal Material style is applied. There are packages to enhance the look ad feel:
Simple: [bottom_navy_bar](https://pub.dev/packages/bottom_navy_bar)
With Action Button [bubble_bottom_bar](https://pub.dev/packages/bubble_bottom_bar)

#### DeepLinking
GoRouter support Deep-Links out of the box, but you need to enable on iOS/Android: 

[Android manifest](/android/app/src/main/AndroidManifest.xml).

```
  <meta-data
      android:name="flutter_deeplinking_enabled"
      android:value="true" />
```

[ios -> info.plist](ios/Runner/Info.plist)

``` 
<key>FlutterDeepLinkingEnabled</key>
	<true/>
```

On Android:
Android use "App Links" which works similar to "Universal links" on iOS If the app is installed a
bottomSheet will let you decide between opening in app or mobile browser. If the app isn't
installed, the link will open in mobile browser.

Social-Media preview Tags and images come out of the box from [index.html](web/index.html)

```
<title>dedeApp</title>
<meta name="description" content="Create and share wishlist easy and cost free">
```

On iOS:  
iOS use [Universal Links][17] which work similar to "App Links" on Android. Older iOS Version (<9)
use "customScheme".

You could check if an url is a "universal link" using [apple validation tool][18]

## Assets

The `assets` directory houses images, fonts, and any other files you want to include with your
application.

The `assets/images` directory
contains [resolution-aware images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware)
.

## Localization

This project generates localized messages based on arb files found in the `lib/src/localization`
directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

## Firebase

#### FlutterFireUI
Used Flutter UI for SignIn. 
This handles all the auth logic incl. reading the magic link using FirebaseDynamicLinks out of the box. 
**!! Sadly the [profile page](lib/src/auth_feat/profile_view.dart) is not working correctly !!**

ToDo: enable hosting to read magic-links on desktop and show some meaningful content.  
For example -> "open this link with your mobile phone"

#### Firebase Auth
Auth Logic which is not handled by the FlutterFireUI is located in [auth_repo.dart](lib/src/auth_feat/auth_repo.dart)

Test Login using **Magic-Link**: 
- Android: 
```
adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d {magic-link} 
```

- iOS:
To test deeplink on iOS on Simulator you need to user *customscheme* as follow:
```
xcrun simctl openurl booted app.fitgeneration.fitGeneration:{magic-link w/o https}
```