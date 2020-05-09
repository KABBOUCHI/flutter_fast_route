import 'package:fast_route/fast_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/home.dart';
import 'views/login.dart';
import 'views/post.dart';
import 'views/posts.dart';

List<FastRoute> routes = [
  FastRoute(
    path: '/',
    name: 'home',
    builder: (context, params) => Home(),
    beforeEnter: _authGuard,
  ),
  FastRoute(
    path: '/login',
    name: "login",
    builder: (context, params) => Login(),
  ),
  FastRoute(
    path: '/posts',
    name: 'posts',
    builder: (context, params) => Posts(),
    beforeEnter: _authGuard,
  ),
  FastRoute(
    path: '/posts/:id',
    name: 'post',
    builder: (context, params) => Post(
      id: params['id'],
    ),
    beforeEnter: _authGuard,
  )
];

Future<FastRouteLocation> _authGuard(
    FastRouteLocation from, FastRouteLocation to) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool('loggedIn');

  if (isLoggedIn == false) {
    return FastRouter.routeByName('login');
  }

  return to;
}
