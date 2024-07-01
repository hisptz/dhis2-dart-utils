// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dhis2_option.dart';

//
// `Dhis2TrackedEntityAttribute` is a data model class for the DHIS2 Tracked entity attributes metadata
//
class Dhis2TrackedEntityAttribute {
  // This is the DHIS2 id that identified a data element
  String? id;

  // This is the DHIS2 display name for a given data element
  String? displayName;

  // This is a the value type of the given data element
  // It has to conform to the DHIS2 data types, for example `TEXT`, `NUMBER` or `BOOLEAN` etc
  String? valueType;

  // This is the DHIS2 id for the data set associated with the Data element if any
  String? optionSet;

  // This is the list of `Dhis2Option` associated with the data elements
  List<Dhis2Option>? options;

  // This is the default constructor of the `Dhis2TrackedEntityAttribute`
  Dhis2TrackedEntityAttribute({
    required this.id,
    required this.valueType,
    required this.displayName,
    this.optionSet = '',
    this.options = const [],
  });

  // `Dhis2TrackedEntityAttribute.toMap` is a method that converts the `Dhis2TrackedEntityAttribute` to a `Map` object
  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['displayName'] = displayName;
    data['valueType'] = valueType;
    data['optionSet'] = optionSet;
    return data;
  }

  // `Dhis2TrackedEntityAttribute.fromMap` is a constructor method that generates `Dhis2TrackedEntityAttribute` from a `Map` object
  Dhis2TrackedEntityAttribute.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    displayName = mapData['displayName'];
    valueType = mapData['valueType'];
    optionSet = mapData['optionSet'];
  }

  // `Dhis2TrackedEntityAttribute.fromJson` is a factory constructor method that generates `Dhis2TrackedEntityAttribute` from a `dynamic` json object
  factory Dhis2TrackedEntityAttribute.fromJson(
    dynamic json,
  ) {
    Map optionSetObj = json['optionSet'] ?? {};
    return Dhis2TrackedEntityAttribute(
      id: json['id'] ?? '',
      displayName: json['displayName'] ?? '',
      valueType: json['valueType'] ?? '',
      optionSet: optionSetObj['id'] ?? '',
    );
  }

  @override

  // This is the `toString()` method that return the string representation of the `Dhis2TrackedEntityAttribute`
  String toString() {
    return '<$id $valueType $options>';
  }
}
