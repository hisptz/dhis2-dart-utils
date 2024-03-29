// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

//
// `Dhis2EventDataValue` is a data model class for the DHIS2 Data element metadata
//
class Dhis2EventDataValue {
  // This is the DHIS2 id assigned to the data value
  String? id;

  // This is the DHIS2 id assigned to an event associated with the `Dhis2Event` to which this `Dhis2EventDataValue` belongs
  String? event;

  // This is the DHIS2 id assigned to an event associated with `Dhis2DataElement` to which the `Dhis2EventDataValue`  belongs
  String? dataElement;

  // This is the value of the `Dhis2EventDataValue`
  String? value;

  // This is the time for creation of the `Dhis2EventDataValue`
  String? created;

  // This is the time stamp for the last updating time of the `Dhis2EventDataValue`
  String? lastUpdated;

  // This is the default constructor for `Dhis2EventDataValue`
  Dhis2EventDataValue({
    required this.event,
    required this.dataElement,
    this.created,
    this.lastUpdated,
    this.value = '',
  }) {
    id = '${event}_$dataElement';
  }

  // `Dhis2EventDataValue.toMap` is a method that converts the `Dhis2EventDataValue` to a `Map` object
  Map<String, dynamic> toMap() {
    var now = DateTime.now().toIso8601String();
    var data = <String, dynamic>{};
    data['id'] = id;
    data['event'] = event;
    data['dataElement'] = dataElement;
    data['created'] = created ?? now;
    data['lastUpdated'] = lastUpdated ?? now;
    data['value'] = value;
    return data;
  }

  // `Dhis2EventDataValue.fromMap` is a constructor that generated a `Dhis2EventDataValue` from a `Map` object
  Dhis2EventDataValue.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    event = mapData['event'];
    dataElement = mapData['dataElement'];
    created = mapData['created'];
    lastUpdated = mapData['lastUpdated'];
    value = mapData['value'];
  }

  // `Dhis2EventDataValue.fromJson` is a factory constructor that generated a `Dhis2EventDataValue` from a `dynamic` json
  factory Dhis2EventDataValue.fromJson(
    dynamic json,
    String eventId,
  ) {
    var now = DateTime.now().toIso8601String();
    return Dhis2EventDataValue(
      event: eventId,
      dataElement: json['dataElement'] ?? '',
      created: json['created'] ?? now,
      lastUpdated: json['lastUpdated'] ?? now,
      value: json['value'] ?? '',
    );
  }

  // This is the `toString()` method that return the string representation of the `Dhis2EventDataValue`
  @override
  String toString() {
    return '<$id $value>';
  }
}
