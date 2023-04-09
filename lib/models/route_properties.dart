class RouteProperties {
  final String? _route;
  final String? _name;
  final Map<String, String?>? _params;

  String? get route => _route;
  String? get name => _name;
  Map<String, String?>? get params => _params;

  const RouteProperties(
      {required String? route,
      required String? name,
      required Map<String, String?>? params})
      : _name = name,
        _route = route,
        _params = params;
}
