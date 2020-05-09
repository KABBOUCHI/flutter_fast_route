import 'package:fast_route/fast_route.dart';
import 'package:flutter/widgets.dart';

class FastRouteLocation {
  FastRoute route;
  Map<String, dynamic> params = {};

  FastRouteLocation({@required this.route, this.params});
}
