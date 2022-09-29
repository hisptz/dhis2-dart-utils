import 'package:dhis2_dart_utils/src/utils/core/helpers/uid_helpers.dart';

class Core {
  static String getUid() {
    return UidHelpers.generateUid();
  }
}
