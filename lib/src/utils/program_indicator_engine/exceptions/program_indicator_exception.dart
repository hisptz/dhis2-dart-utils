class ProgramIndicatorException implements Exception {
  final String cause;

  ProgramIndicatorException(this.cause);

  @override
  String toString() {
    return 'PROGRAM INDICATOR EXCEPTION: $cause';
  }
}
