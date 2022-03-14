extension MapExtension on Map {
  String getString(dynamic key) => dynamicToString(this[key]) ?? '';
}

String? dynamicToString(dynamic value) {
  if (value is String) {
    return value;
  } else {
    return value?.toString();
  }
}