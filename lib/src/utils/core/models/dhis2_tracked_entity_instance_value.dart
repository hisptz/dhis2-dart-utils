// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `Dhis2TrackedEntityInstanceValue` is a data model class for the DHIS2 Data element metadata
///
class Dhis2TrackedEntityInstanceValue {
  /// This is the DHIS2 id assigned to the data value
  String? id;

  /// This is a DHIS2 uid for a given trackedEntityInstance
  String? trackedEntityInstance;

  /// This is the DHIS2 id assigned to an event associated with `Dhis2TrackedEntityAttribute` to which the `Dhis2TrackedEntityInstanceValue`  belongs
  String? attribute;

  /// This is the value of the `Dhis2TrackedEntityInstanceValue`
  String? value;

  /// This is the time for creation of the `Dhis2TrackedEntityInstanceValue`
  String? created;

  /// This is the time stamp for the last updating time of the `Dhis2TrackedEntityInstanceValue`
  String? lastUpdated;

  /// This is the default constructor for `Dhis2TrackedEntityInstanceValue`
  Dhis2TrackedEntityInstanceValue({
    required this.trackedEntityInstance,
    required this.attribute,
    this.created,
    this.lastUpdated,
    this.value = '',
  }) {
    id = '${trackedEntityInstance}_$attribute';
  }

  /// `Dhis2TrackedEntityInstanceValue.toMap` is a method that converts the `Dhis2TrackedEntityInstanceValue` to a `Map` object
  Map<String, dynamic> toMap() {
    var now = DateTime.now().toIso8601String();
    var data = <String, dynamic>{};
    data['id'] = id;
    data['trackedEntityInstance'] = trackedEntityInstance;
    data['attribute'] = attribute;
    data['created'] = created ?? now;
    data['lastUpdated'] = lastUpdated ?? now;
    data['value'] = value;
    return data;
  }

  /// `Dhis2TrackedEntityInstanceValue.fromMap` is a constructor that generated a `Dhis2TrackedEntityInstanceValue` from a `Map` object
  Dhis2TrackedEntityInstanceValue.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    trackedEntityInstance = mapData['trackedEntityInstance'];
    attribute = mapData['attribute'];
    created = mapData['created'];
    lastUpdated = mapData['lastUpdated'];
    value = mapData['value'];
  }

  /// `Dhis2TrackedEntityInstanceValue.fromJson` is a factory constructor that generated a `Dhis2TrackedEntityInstanceValue` from a `dynamic` json
  factory Dhis2TrackedEntityInstanceValue.fromJson(
    dynamic json,
    String trackedEntityInstanceId,
  ) {
    var now = DateTime.now().toIso8601String();
    return Dhis2TrackedEntityInstanceValue(
      trackedEntityInstance: trackedEntityInstanceId,
      attribute: json['attribute'] ?? '',
      created: json['created'] ?? now,
      lastUpdated: json['lastUpdated'] ?? now,
      value: json['value'] ?? '',
    );
  }

  /// This is the `toString()` method that return the string representation of the `Dhis2TrackedEntityInstanceValue`
  @override
  String toString() {
    return '<$id $value>';
  }
}
