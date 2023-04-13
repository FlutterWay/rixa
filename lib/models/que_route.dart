enum NavigationType { go, push, pushReplacement }

class QueRoute {
  String route;
  NavigationType type;
  QueRoute({required this.route, required this.type});
}
