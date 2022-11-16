// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import '../constants/default_values.dart';
import '../exceptions/data_object_exception.dart';

///
/// `DataObjectHelper` is a collection of helper functions for manipulating the form data object
///
class DataObjectHelper {
  ///
  /// `DataObjectHelper.getValueFromDataObject` is a function for getting a value from the the provided data object
  ///  The function takes id of type `String` and a `Map` form data object, and returns a string that is a representation of the value from the data object
  ///
  static String getValueFromDataObject(String uid, Map dataObject) {
    var value = DefaultValues.dataObjectValue;
    try {
      dataObject.forEach((dataObjectKey, dataObjectValue) {
        if (uid.contains(dataObjectKey)) {
          value = '$dataObjectValue';
          return;
        }
      });
    } catch (e) {
      var exception = DataObjectException('getValueFromDataObject($uid) $e');
      print(exception.toString());
    }

    return value;
  }
}
