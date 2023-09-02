// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

///
/// `Dhis2OrganisationUnit` is a data model class for the DHIS2 Organisation unit metadata
///
class Dhis2OrganisationUnit {
  /// This is the DHIS2 id for the organisation unit
  String? id;

  /// This is a DHIS2 display name for the organisation unit
  String? name;

  /// This is the DHIS2 id of the organisation uni that is parent to the current one
  String? parent;

  /// This is a DHIS2 code assigned to the organisation unit
  String? code;

  /// This is a DHIS2 path for the organisation unit
  String? path;

  /// This is a DHIS2 level to which the organisation unit belong
  /// It is taken as the `int` representation of the
  int? level;

  /// This is a list of DHIS2 ids for the Datasets associated with the organisation unit
  List<String>? dataSets;

  /// This is a list of DHIS2 ids for the Programs associated with the organisation unit
  List<String>? programs;

  /// This is a list of DHIS2 ids for `Dhis2OrganisationUnit` that are children to the current organisation unit in the DHIS2 hierarchy
  List<String>? children;

  /// This is a `Map` object that contains the geometry information for the organisation unit as configured in DHIS2 instance
  Map<String, dynamic>? geometry;

  /// This is the default constructor for the `Dhis2OrganisationUnit`
  Dhis2OrganisationUnit({
    required this.id,
    required this.name,
    this.parent = '',
    this.code = '',
    this.path = '',
    this.level = 0,
    this.dataSets = const [],
    this.programs = const [],
    this.children = const [],
    this.geometry = const {},
  });

  /// `Dhis2OrganisationUnit.toMap` is a method that converts the `Dhis2OrganisationUnit` to a `Map` object
  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent'] = parent;
    data['code'] = code;
    data['level'] = level;
    data['path'] = path;
    data['geometry'] = jsonEncode(geometry ?? {});
    return data;
  }

  /// `Dhis2OrganisationUnit.fromMap` is a constructor that generated a `Dhis2OrganisationUnit` from a `Map` object
  Dhis2OrganisationUnit.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    name = mapData['name'];
    parent = mapData['parent'];
    code = mapData['code'];
    level = int.parse(mapData['level']);
    parent = mapData['parent'];
    geometry = jsonDecode(mapData['geometry'] ?? '{}');
  }

  /// `Dhis2OrganisationUnit.fromJson` is a factory constructor that generated a `Dhis2OrganisationUnit` from a `dynamic` json
  factory Dhis2OrganisationUnit.fromJson(
    dynamic json,
  ) {
    Map parentObj = json['parent'] ?? {};
    List<dynamic>? programList = json['programs'] as List<dynamic>?;
    List<dynamic>? dataSetList = json['dataSets'] as List<dynamic>?;
    List<dynamic>? childrenList = json['children'] as List<dynamic>?;
    Map<String, dynamic> geometry = json['geometry'] ?? {};
    return Dhis2OrganisationUnit(
      id: json['id'],
      name: json['name'] ?? '',
      parent: parentObj['id'] ?? '',
      code: json['code'],
      level: json['level'],
      programs:
          (programList ?? []).map((program) => '${program["id"]}').toList(),
      dataSets:
          (dataSetList ?? []).map((dataSet) => '${dataSet["id"]}').toList(),
      children: (childrenList ?? []).map((child) => '${child["id"]}').toList(),
      geometry: geometry,
    );
  }

  /// This is the `toString()` method that return the string representation of the `Dhis2OrganisationUnit`
  @override
  String toString() {
    return '<$id : $name $level>';
  }
}
