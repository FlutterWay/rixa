extension StringExtension on String {
  String capitalize() {
    return this == "" ? "" : "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension CapExtension on String {
  String get inCaps =>
      this == "" ? "" : '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.capitalize()).join(" ");
}
