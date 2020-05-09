import 'package:fast_route/fast_route.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String id;
  const Post({this.id, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Text('Post $id'),
            Container(),
            RaisedButton(
              onPressed: () async {
                FastRouter.pop();
              },
              child: Text('Back'),
            )
          ],
        ),
      ),
    );
  }
}
