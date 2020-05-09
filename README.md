# fast_route

fast_route is a custom Flutter routing library inspired by [vue-router](https://github.com/vuejs/vue-router).

[![Version](https://img.shields.io/badge/version-0.0.2-blue.svg)](https://pub.dartlang.org/packages/fast_route)

## Getting started

You should ensure that you add the router as a dependency in your flutter project.

```yaml
dependencies:
 fast_route: "^0.0.2"
```

## Example

```dart
import 'package:fast_route/fast_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<FastRoute> routes = [
  FastRoute(
    path: '/',
    builder: (context, params) => Home(),
    beforeEnter: (from,to) async { // Custom guard

        SharedPreferences prefs = await SharedPreferences.getInstance();

        bool isLoggedIn = prefs.getBool('loggedIn');

        if (isLoggedIn == false) {
            return FastRouter.routeByName('login');
        }

        return to;   
    },
  ),
  FastRoute(
    path: '/login',
    name: "login",
    builder: (context, params) => Login(),
  ),
];

```


```dart
import 'package:fast_route/fast_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<FastRoute> routes = [
  FastRoute(
    path: '/',
    builder: (context, params) => Home(),
    beforeEnter: (from,to) async { // Custom guard

        SharedPreferences prefs = await SharedPreferences.getInstance();

        bool isLoggedIn = prefs.getBool('loggedIn');

        if (isLoggedIn == false) {
            return FastRouter.routeByName('login');
        }

        return to;   
    },
  ),
  FastRoute(
    path: '/login',
    name: "login",
    builder: (context, params) => Login(),
  ),
];

```

```dart
import 'package:fast_route/fast_route.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: FastRouter(
          routes: routes,
        ),
      ),
    );
  }
}
```