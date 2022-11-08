import '../constants/fixed.dart';
import 'period_type.dart';

class PeriodUtility {
  static getPeriodTypeById(String id) {
    List<Map<String, dynamic>> periodTypes = [...fixedPeriodTypes];
    Map<String, dynamic>? periodType = periodTypes
        .firstWhere((element) => element['id'] == id, orElse: () => {});
    return PeriodType(periodType);
  }
}
