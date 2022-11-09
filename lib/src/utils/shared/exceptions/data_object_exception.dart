class DataObjectException implements Exception {
  final String cause;

  DataObjectException(this.cause);

  @override
  String toString() {
    return 'PROGRAM INDICATOR EXCEPTION: $cause';
  }
}
