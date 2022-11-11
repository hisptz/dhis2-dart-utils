// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `ProgramRuleAction` is the data model class that defines the program rule actions
///
class ProgramRuleAction {
  /// This is a DHIS2 id for the rule action
  String? id;

  /// This is the linkage to a `ProgramRule`, its is a string uid of the respective program rule for the current action
  String? programRule;

  /// This is the data to be assigned based on the program rule action type
  String? data;

  /// This is the the message content if the program rule action shows an error or warning message
  String? content;

  /// This is the type of the action a particular program rule should perform by the program rule action
  String? programRuleActionType;

  String? location;

  /// This is the id for the data element associated by the program rule action
  String? dataElement;

  /// This is the id for the tracked entity attribute associated by the program rule action
  String? trackedEntityAttribute;

  /// This is the id for  program stage section associated by the program rule action
  String? programStageSection;

  /// This is the id for the program stage associated by the program rule action
  String? programStage;

  ///
  /// This is a default constructor for the `ProgramRuleAction`
  ///
  ProgramRuleAction({
    required this.id,
    required this.programRule,
    this.data = '',
    this.content = '',
    this.programRuleActionType = '',
    this.location = '',
    this.dataElement = '',
    this.trackedEntityAttribute = '',
    this.programStageSection = '',
    this.programStage = '',
  });

  ///
  /// `ProgramRuleAction.toMap()` is a function to convert a program rule action to a corresponding map representation
  ///
  Map<String, dynamic> toMap() {
    var mapData = <String, dynamic>{};
    mapData['id'] = id;
    mapData['programRule'] = programRule;
    mapData['data'] = data;
    mapData['content'] = content;
    mapData['programRuleActionType'] = programRuleActionType;
    mapData['location'] = location;
    mapData['dataElement'] = dataElement;
    mapData['trackedEntityAttribute'] = trackedEntityAttribute;
    mapData['programStageSection'] = programStageSection;
    mapData['programStage'] = programStage;
    return mapData;
  }

  ///
  /// `ProgramRuleAction.fromMap` is a constructor that generates the `ProgramRuleAction` from a `Map` object
  /// The function accepts a `Map` object and returns `ProgramRuleAction`
  ///
  ProgramRuleAction.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    programRule = mapData['programRule'];
    data = mapData['data'] ?? '';
    content = mapData['content'];
    programRuleActionType = mapData['programRuleActionType'];
    location = mapData['location'];
    dataElement = mapData['dataElement'];
    trackedEntityAttribute = mapData['trackedEntityAttribute'];
    programStageSection = mapData['programStageSection'];
    programStage = mapData['programStage'];
  }

  ///
  /// `ProgramRuleAction.fromJson` is a constructor that generates the `ProgramRuleAction` from a JSON object
  ///
  factory ProgramRuleAction.fromJson(
    dynamic json,
  ) {
    Map programRule = json['programRule'] ?? {};
    Map dataElement = json['dataElement'] ?? {};
    Map trackedEntityAttribute = json['trackedEntityAttribute'] ?? {};
    Map programStageSection = json['program'] ?? {};
    Map programStage = json['programStage'] ?? {};
    return ProgramRuleAction(
      id: json['id'],
      programRule: programRule['id'] ?? '',
      data: json['data'] ?? '',
      content: json['content'] ?? '',
      programRuleActionType: json['programRuleActionType'] ?? '',
      location: json['location'] ?? '',
      dataElement: dataElement['id'] ?? '',
      trackedEntityAttribute: trackedEntityAttribute['id'] ?? '',
      programStageSection: programStageSection['id'] ?? '',
      programStage: programStage['id'] ?? '',
    );
  }

  /// This is an override  `toString()`function for debugging
  @override
  String toString() {
    return '<$id $programRuleActionType $programRule>';
  }
}
