// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

/// `CoordinatesHelpers` is a helper class for converting DHIS2 coordinates metadata
class CoordinatesHelpers {
  /// This is a method for converting DHIS2 coordinates metadata to a string
  /// It takes a `Map<String, dynamic>` object as an argument
  /// the input is has a format like:
  /// ```
  /// {
  ///  "type": "POINT",
  /// "coordinates": [1, 1]
  /// }
  /// ```
  static String getStringifiedCoordinates(Map<String, dynamic> geometry) {
    if ('${geometry['type']}'.toUpperCase() == 'POINT') {
      List<dynamic> coordinates = geometry['coordinates'];
      return '${coordinates.first},${coordinates.last}';
    } else {
      return '';
    }
  }
}
