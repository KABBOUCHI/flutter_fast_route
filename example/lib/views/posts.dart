import 'dart:convert';

import 'package:fast_route/fast_route.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Posts extends StatelessWidget {
  const Posts({Key key}) : super(key: key);

  Future<http.Response> fetchPosts() {
    return http.get('https://jsonplaceholder.typicode.com/posts');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<http.Response>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> posts = json.decode(snapshot.data.body);

            return ListView(
              children: posts
                  .map((post) => ListTile(
                        onTap: () {
                          FastRouter.pushNamed(
                            'post',
                            {'id': post['id'].toString()},
                          );
                        },
                        title: Text(post['title']),
                      ))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
