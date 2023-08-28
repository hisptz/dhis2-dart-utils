// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

/// `CoordinatesHelpers` is a helper class for converting DHIS2 coordinate metadata
class CoordinatesHelpers {
  /// This is a method for converting DHIS2 coordinate metadata to a string
  /// It takes a `Map<String, dynamic>` object as an argument
  /// the input is has a format like:
  /// ```
  /// {
  ///  "type": "POINT",
  /// "coordinate": [1, 1]
  /// }
  /// ```
  static String getStringifiedCoordinatesFromGeometry(
      Map<String, dynamic> geometry) {
    if ('${geometry['type']}'.toUpperCase() == 'POINT') {
      List<dynamic> coordinate = geometry['coordinate'];
      return '${coordinate.first},${coordinate.last}';
    } else {
      return '';
    }
  }

  /// This is a method for converting DHIS2 coordinate metadata to a string
  /// It takes a `Map<String, dynamic>` object as an argument
  /// the input is has a format like:
  /// ```
  /// {
  /// "latitude": 1,
  /// "longitude": 1
  /// }
  /// ```

  static getStringifiedCoordinatesFromCoordinatesObject(
      Map<String, dynamic> coordinate) {
    return '${coordinate['latitude']},${coordinate['longitude']}';
  }
}
