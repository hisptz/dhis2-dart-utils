// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

//
// `ProgramRuleVariable` is the data model class that defines the program rule variables
//

class ProgramRuleVariable {
  // This is a DHIS2 id for a program rule variable
  String? id;

  // This is the name given to a given program rule variable
  String? name;

  // This is the source of the value for a given program rule variable
  String? programRuleVariableSourceType;

  // this is the id of a program to which the program rule variable is assigned
  String? program;

  // This is a target data element that is connected to the program rule variable
  String? dataElement;

  // This is a target tracked entity attribute that is connected to the program rule variable
  String? trackedEntityAttribute;

  // This is a target program stage section that is connected to the program rule variable
  String? programStageSection;

  // This is a target program stage that is connected to the program rule variable
  String? programStage;

  //
  // This is a default constructor for `ProgramRuleVariable`
  //
  ProgramRuleVariable({
    required this.id,
    required this.name,
    required this.program,
    this.programRuleVariableSourceType,
    this.dataElement = '',
    this.trackedEntityAttribute = '',
    this.programStageSection = '',
    this.programStage = '',
  });

  //
  // `ProgramRuleVariable.toMap()` is a function to convert a program rule variable to a corresponding map representation
  //
  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['program'] = program;
    data['dataElement'] = dataElement;
    data['trackedEntityAttribute'] = trackedEntityAttribute;
    data['programStageSection'] = programStageSection;
    data['programStage'] = programStage;
    return data;
  }

  //
  // `ProgramRuleVariable.fromMap` is a constructor that generates the `ProgramRuleVariable` from a `Map` object
  // The function accepts a `Map` object and returns `ProgramRuleVariable`
  //
  ProgramRuleVariable.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    name = mapData['name'];
    program = mapData['program'];
    dataElement = mapData['dataElement'];
    trackedEntityAttribute = mapData['trackedEntityAttribute'];
    programStageSection = mapData['programStageSection'];
    programStage = mapData['programStage'];
  }

  //
  // `ProgramRuleVariable.fromJson` is a constructor that generates the `ProgramRuleVariable` from a JSON object
  //
  factory ProgramRuleVariable.fromJson(
    dynamic json,
  ) {
    Map program = json['program'] ?? {};
    Map dataElement = json['dataElement'] ?? {};
    Map trackedEntityAttribute = json['trackedEntityAttribute'] ?? {};
    Map programStageSection = json['program'] ?? {};
    Map programStage = json['programStage'] ?? {};
    return ProgramRuleVariable(
      id: json['id'],
      name: json['name'],
      programRuleVariableSourceType:
          json['programRuleVariableSourceType'] ?? '',
      program: program['id'] ?? '',
      dataElement: dataElement['id'] ?? '',
      trackedEntityAttribute: trackedEntityAttribute['id'] ?? '',
      programStageSection: programStageSection['id'] ?? '',
      programStage: programStage['id'] ?? '',
    );
  }

  // This is an override  `toString()`function for debugging
  @override
  String toString() {
    return '<$id $name $program>';
  }
}
