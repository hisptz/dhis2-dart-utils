// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dhis2_dart_utils/src/utils/core/helpers/uid_helpers.dart';

/// The Core class contains different DHIS2 core functions
///
///
class Core {
  /// This is a static function for generation of random dhis2 UIDS
  /// ```dart
  /// var uid = Core.getUid(); // uid will be a 11 alphanumeric characters string starting with an alphabet
  ///
  /// ```
  ///
  static String getUid() {
    return UidHelpers.generateUid();
  }
}
