// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `Dhis2Option` is a data model class for the DHIS2 Option metadata
///
class Dhis2Option {
  /// This is the DHIS2 id assigned to the Option
  String? id;

  /// This is the name for the DHIS2 option
  String? name;

  /// This is the DHIS2 code assigned to an option
  String? code;

  /// This is the DHIS2 id assigned to the OptionSet to which the option comes from
  String? optionSet;

  /// This is a sort order for the Option
  int? sortOrder;

  /// This is the default constructor for the `Dhis2Option`
  Dhis2Option({
    required this.id,
    required this.name,
    required this.code,
    required this.optionSet,
    required this.sortOrder,
  });

  /// `Dhis2Option.toMap` is the method that converts the `Dhis2Option` to a `Map` object
  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['optionSet'] = optionSet;
    data['sortOrder'] = sortOrder;
    return data;
  }

  /// `Dhis2Option.fromMap` is a constructor method that generated the `Dhis2Option` from a `Map` object
  /// It Accepts a `Map` object and returns a `Dhis2Option`
  Dhis2Option.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    name = mapData['name'];
    code = mapData['code'];
    optionSet = mapData['optionSet'];
    sortOrder = int.parse(mapData['sortOrder']);
  }

  /// `Dhis2Option.fromJson` is a factory constructor method that generated the `Dhis2Option` from a `dynamic` json
  /// It Accepts a `dynamic` json and returns a `Dhis2Option`
  factory Dhis2Option.fromJson(
    dynamic json,
  ) {
    return Dhis2Option(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      optionSet: json['optionSet'] ?? '',
      sortOrder: json['sortOrder'] ?? 0,
    );
  }

  /// This is the `toString()` method that return the string representation of the `Dhis2Option`
  @override
  String toString() {
    return '<$id $name $code $sortOrder>';
  }
}
