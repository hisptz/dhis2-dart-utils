// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

/// `CoordinatesHelpers` is a helper class for converting DHIS2 coordinate metadata
class CoordinatesHelpers {
  /// This is a method for converting coordinate number to radian
  static double _getRadian(double? coordinateNumber) {
    return coordinateNumber == null ? 0 : coordinateNumber * pi / 180;
  }

  /// This is a method for checking if two coordinates are within a given radius
  /// It takes a `List<double>` firstPoint,`List<double>` second point and the `double` radius in meters  as named arguments
  /// The `List<double>` arguments are expected to have the format `[latitude, longitude]`
  /// The method returns a `bool` value
  static bool areCoordinatesWithinRadius({
    required List<double> firstPoint,
    required List<double> secondPoint,
    required double radiusInMeters,
  }) {
    final double earthRadius = 6371000;
    double latitudeDistance =
        _getRadian(firstPoint.first) - _getRadian(secondPoint.first);
    double longitudeDistance =
        _getRadian(firstPoint.last) - _getRadian(secondPoint.last);

    // calculate distance using  haversine formula
    double a = pow(sin(latitudeDistance / 2), 2) +
        cos(_getRadian(firstPoint.first)) *
            cos(_getRadian(secondPoint.first)) *
            pow(sin(longitudeDistance / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadius * c;

    return distance <= radiusInMeters;
  }

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
      List<dynamic> coordinates = geometry['coordinates'];
      return '${coordinates.first},${coordinates.last}';
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
