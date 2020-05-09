import 'package:fast_route/fast_route.dart';
import 'package:flutter/widgets.dart';

typedef RouterBeforeEnter = Future<FastRouteLocation> Function(
  FastRouteLocation from,
  FastRouteLocation to,
);

class FastRoute {
  String path;
  String name;
  RouterBeforeEnter beforeEnter;
  Map<String, dynamic> meta;
  Widget Function(BuildContext context, Map<String, dynamic> params) builder;

  FastRoute({
    this.path,
    this.name,
    this.beforeEnter,
    this.meta,
    this.builder,
  });
}
