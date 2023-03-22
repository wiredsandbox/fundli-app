String toRfc3339String(DateTime dateTime) {
  final String rfc3339String =
      dateTime.toIso8601String().replaceAll('Z', '+00:00');
  return rfc3339String;
}
