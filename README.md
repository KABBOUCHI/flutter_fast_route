# [WIP] fast_route

fast_route is a custom Flutter routing library inspired by [vue-router](https://github.com/vuejs/vue-router).

[![Version](https://img.shields.io/badge/version-0.0.2-blue.svg)](https://pub.dartlang.org/packages/fast_route)

**Note this is early WIP! Currently the focus is on making it stable and feature complete first. It is not recommended to use this for anything serious yet.**

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
    beforeEnter: (from, to) async { // Custom guard

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
  FastRoute(
    path: '/posts/:id',
    name: 'post',
    builder: (context, params) => Post(
      id: params['id'],
    ),
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

```dart
FastRouter.pushNamed('home');

FastRouter.pushNamed('post', { 'id' : 1 });
```