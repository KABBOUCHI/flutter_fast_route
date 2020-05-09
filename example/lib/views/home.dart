import 'package:fast_route/fast_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(children: [
        Text('Home'),
        RaisedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('loggedIn', false);

            FastRouter.pushNamed('login');
          },
          child: Text('Logout'),
        ),
        RaisedButton(
          onPressed: () async {
            FastRouter.pushNamed('posts');
          },
          child: Text('Posts'),
        )
      ]),
    );
  }
}
