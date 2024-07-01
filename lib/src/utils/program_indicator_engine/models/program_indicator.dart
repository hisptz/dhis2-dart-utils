// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

//
// This is a data modal class for the Program Indicators
//
class ProgramIndicator {
  // This is the DHIS2 Id for a given indicators
  String? id;

  // This is a string value representing the  Aggregation type during data analysis for the program indicators
  String? aggregationType;

  // This is the expression that is to be evaluated on the program indicator
  String? expression;

  // This is the filter for reducing the data to which the program indicator will be evaluated during aggregation
  String? filter;

  // This is the program to which the program indicator is evaluated
  String? program;

  //
  // Program indicator can be instantiated with the `ProgramIndicator` default constructor
  //
  ProgramIndicator({
    required this.id,
    required this.aggregationType,
    required this.expression,
    required this.program,
    this.filter = '',
  });

  // This is a function that converts the `ProgramIndicator` to a `Map`
  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['aggregationType'] = aggregationType;
    data['expression'] = expression;
    data['program'] = program;
    data['filter'] = filter;
    return data;
  }

  //
  // `ProgramIndicator.fromMap` is an additional constructor for generating a `ProgramIndicator` object from a `Map`
  //
  ProgramIndicator.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    aggregationType = mapData['aggregationType'];
    expression = mapData['expression'];
    program = mapData['program'];
    filter = mapData['filter'];
  }

  //
  // `ProgramIndicator.fromJson` is an additional constructor for generating a `ProgramIndicator` object from a JSON object
  //
  factory ProgramIndicator.fromJson(
    dynamic json,
  ) {
    Map programObj = json['program'] ?? {};
    return ProgramIndicator(
      id: json['id'],
      expression: json['expression'],
      aggregationType: json['aggregationType'],
      program: programObj['id'] ?? '',
      filter: json['filter'] ?? '',
    );
  }

  // An override to `toString` for debugging
  @override
  String toString() {
    return '<$id : $program>';
  }
}
