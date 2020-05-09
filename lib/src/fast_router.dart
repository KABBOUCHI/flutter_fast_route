import 'package:fast_route/fast_route.dart';
import 'package:flutter/widgets.dart';

GlobalKey<_FastRouterState> fastRouterKey = GlobalKey();

class FastRouter extends StatefulWidget {
  final List<FastRoute> routes;

  FastRouter({this.routes}) : super(key: fastRouterKey);

  @override
  _FastRouterState createState() => _FastRouterState();

  static void pushNamed(String name, [Map<String, dynamic> params]) {
    fastRouterKey.currentState.pushNamed(name, params);
  }

  static FastRouteLocation routeByName(String name,
      [Map<String, String> params]) {
    return FastRouteLocation(
      route: fastRouterKey.currentState.widget.routes
          .firstWhere((r) => r.name == name),
      params: params,
    );
  }

  static void pop() {
    fastRouterKey.currentState.pop();
  }
}

class _FastRouterState extends State<FastRouter> {
  int _beforeRouteIndex = 0;
  Map<String, dynamic> _beforeRouteParams = {};

  int _routeIndex = 0;
  Map<String, dynamic> _routeParams = {};

  void pop() {
    setState(() {
      _routeIndex = _beforeRouteIndex;
      _routeParams = _beforeRouteParams;
    });
  }

  void pushNamed(String name, [Map<String, dynamic> params]) {
    int routeIndex = widget.routes.indexWhere((r) => r.name == name);

    if (routeIndex != -1) {
      setState(() {
        _beforeRouteIndex = _routeIndex;
        _beforeRouteParams = _routeParams;

        _routeIndex = routeIndex;
        _routeParams = params;
      });
    }
  }

  Future<Widget> routeWidget(BuildContext context) async {
    FastRoute route = widget.routes[_routeIndex];

    if (route.beforeEnter != null) {
      FastRoute beforeRoute = widget.routes[_beforeRouteIndex];
      FastRouteLocation location = await route.beforeEnter(
        FastRouteLocation(route: beforeRoute, params: _beforeRouteParams),
        FastRouteLocation(route: route, params: _routeParams),
      );

      route = location.route;
      _routeParams = location.params;
    }

    return route.builder.call(
      context,
      _routeParams,
    );
  }

  @override
  Widget build(context) {
    return FutureBuilder<Widget>(
      future: routeWidget(context),
      builder: (context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        }

        if (snapshot.hasError) {
          throw snapshot.error;
        }

        return Container(
          child: Text('Error'),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     builder: routeWidget(context),
  //   );
  // }
}
