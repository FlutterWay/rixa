class ScreenModeLimits {
  // ignore: unused_field
  final double _mobile, _landScape, _desktopMini;

  double get mobile => _mobile;
  double get landScape => _landScape;
  double get desktopMini => _desktopMini;
  ScreenModeLimits({
    required double mobile,
    required double landScape,
    required double desktopMini,
  })  : _mobile = mobile,
        _landScape = landScape,
        _desktopMini = desktopMini;
}
