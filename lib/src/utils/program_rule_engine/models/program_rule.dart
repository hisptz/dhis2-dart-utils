import 'program_rule_action.dart';

class ProgramRule {
  String? id;
  String? condition;
  String? program;
  List<ProgramRuleAction>? programRuleActions;

  ProgramRule({
    required this.id,
    required this.program,
    this.condition = '',
    this.programRuleActions = const [],
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['program'] = program;
    data['condition'] = condition;
    return data;
  }

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

  @override
  String toString() {
    return '<$id $program>';
  }
}
