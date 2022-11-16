// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'program_rule_action.dart';

///
/// `ProgramRule` is the data model class that defines the program rules
///
class ProgramRule {
  /// This is a DHIS2 id for a given program rule
  String? id;

  /// This is a string condition for which the program rule is evaluated
  /// When the evaluation of this condition returns `true`, then the `ProgramRuleAction` associated with this rule will be performed
  String? condition;

  /// this the id of the program that is associated with the program rule
  String? program;

  /// This is a list of `ProgramRuleAction` that are performed when the `ProgramRule` condition is `true`.
  List<ProgramRuleAction>? programRuleActions;

  ///
  /// This is a default constructor for `ProgramRule`
  ///
  ProgramRule({
    required this.id,
    required this.program,
    this.condition = '',
    this.programRuleActions = const [],
  });

  ///
  /// `ProgramRule.toMap()` is a function to convert a program rule to a corresponding map representation
  ///
  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['program'] = program;
    data['condition'] = condition;
    return data;
  }

  ///
  /// `ProgramRule.fromMap` is a constructor that generates the `ProgramRule` from a `Map` object
  /// The function accepts a `Map` object and returns `ProgramRule`
  ///
  ProgramRule.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    program = mapData['program'];
    condition = mapData['condition'];
    programRuleActions =
        ((mapData['programRuleActions'] as List<Map<String, dynamic>>?) ?? [])
            .map((programRuleAction) =>
                ProgramRuleAction.fromMap(programRuleAction))
            .toList();
  }

  ///
  /// `ProgramRule.fromJson` is a constructor that generates the `ProgramRule` from a JSON object
  ///
  factory ProgramRule.fromJson(
    dynamic json,
  ) {
    Map program = json['program'] ?? {};
    return ProgramRule(
      id: json['id'],
      program: program['id'] ?? '',
      condition: json['condition'],
    );
  }

  /// This is an override  `toString()`function for debugging
  @override
  String toString() {
    return '<$id $program>';
  }
}
