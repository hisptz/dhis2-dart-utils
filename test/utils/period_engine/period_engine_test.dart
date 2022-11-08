import 'package:dart_date/dart_date.dart';
import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';
import 'package:dhis2_dart_utils/src/utils/period_engine/constants/enums.dart';
import 'package:test/test.dart';

List<int> years = [
  2010,
  2011,
  2012,
  2013,
  2014,
  2015,
  2016,
  2017,
  2018,
  2019,
  2020,
  2021,
  2022,
  2023,
  2024,
  2025
];
List<Map<String, dynamic>> fixedPeriodsTests = [
  {
    "id": PeriodTypes.DAILY,
    "periodIdTest": RegExp(r'^(\d{4})(\d{2})(\d{2})$'),
    "periodNameTest": RegExp(r'^(\d{4})-(\d{2})-(\d{2})$'),
    "noOfPeriods": (year) => DateTime(year).getDaysInYear,
    "description": "Daily Period type test",
  },
  {
    "id": PeriodTypes.WEEKLY,
    "periodIdTest": RegExp(r'^(\d{4})W(\d{1,2})$'),
    "periodNameTest": RegExp(
        r'^Week ([0-9]+) ([0-9]{4})-([0-9]{2})-([0-9]{2}) - ([0-9]{4})-([0-9]{2})-([0-9]{2})$'),
    "noOfPeriods": (year) => DateTime(year).getISOWeeksInYear,
    "description": "Weekly Period type test",
  },
  {
    "id": PeriodTypes.WEEKLYWED,
    "periodIdTest": RegExp(r'^(\d{4})(Wed)W(\d{1,2})$'),
    "periodNameTest": RegExp(
        r'^Week ([0-9]+) ([0-9]{4})-([0-9]{2})-([0-9]{2}) - ([0-9]{4})-([0-9]{2})-([0-9]{2})$'),
    "noOfPeriods": (year) => DateTime(year).getISOWeeksInYear,
    "description": "Weekly Period type test",
  },
  {
    "id": PeriodTypes.WEEKLYTHU,
    "periodIdTest": RegExp(r'^(\d{4})(Thu)W(\d{1,2})$'),
    "periodNameTest": RegExp(
        r'^Week ([0-9]+) ([0-9]{4})-([0-9]{2})-([0-9]{2}) - ([0-9]{4})-([0-9]{2})-([0-9]{2})$'),
    "noOfPeriods": (year) => DateTime(year).getISOWeeksInYear,
    "description": "Weekly Period type test",
  },
  {
    "id": PeriodTypes.WEEKLYSAT,
    "periodIdTest": RegExp(r'^(\d{4})(Sat)W(\d{1,2})$'),
    "periodNameTest": RegExp(
        r'^Week ([0-9]+) ([0-9]{4})-([0-9]{2})-([0-9]{2}) - ([0-9]{4})-([0-9]{2})-([0-9]{2})$'),
    "noOfPeriods": (year) => DateTime(year).getISOWeeksInYear,
    "description": "Weekly Period type test",
  },
  {
    "id": PeriodTypes.WEEKLYSUN,
    "periodIdTest": RegExp(r'^(\d{4})(Sun)W(\d{1,2})$'),
    "periodNameTest": RegExp(
        r'^Week ([0-9]+) ([0-9]{4})-([0-9]{2})-([0-9]{2}) - ([0-9]{4})-([0-9]{2})-([0-9]{2})$'),
    "noOfPeriods": (year) => DateTime(year).getISOWeeksInYear,
    "description": "Weekly Period type test",
  },
  {
    "id": PeriodTypes.BIWEEKLY,
    "periodIdTest": RegExp(r'^([0-9]{4})BiW([0-9]{1,2})$'),
    "periodNameTest": RegExp(
        r'Bi-Week ([0-9]+) ([0-9]{4})-([0-9]{2})-([0-9]{2}) - ([0-9]{4})-([0-9]{2})-([0-9]{2})'),
    "noOfPeriods": (year) => (DateTime(year).getISOWeeksInYear / 2).ceil(),
    "description": "Bi-Weekly Period type test",
  },
  {
    "id": PeriodTypes.MONTHLY,
    "periodIdTest": RegExp(r'^([0-9]{4})([0-9]{2})$'),
    "periodNameTest": RegExp(r'^([A-Za-z])+ ([0-9]{4})$'),
    "noOfPeriods": (year) => 12,
    "description": "Monthly Period type test",
  },
  {
    "id": PeriodTypes.BIMONTHLY,
    "periodIdTest": RegExp(r'^([0-9]{4})([0-9]{2})B$'),
    "periodNameTest": RegExp(r'([A-za-z]+) - ([A-za-z]+) (\d{4})'),
    "noOfPeriods": (year) => 6,
    "description": "Bi-Monthly Period type test",
  },
  {
    "id": PeriodTypes.QUARTERLY,
    "periodIdTest": RegExp(r'^([0-9]{4})Q([1234])$'),
    "periodNameTest": RegExp(r'([A-za-z]+) - ([A-za-z]+) (\d{4})'),
    "noOfPeriods": 4,
    "description": "Quarterly Period type test",
  },
  {
    "id": PeriodTypes.SIXMONTHLY,
    "periodIdTest": RegExp(r'^([0-9]{4})S([12])$'),
    "periodNameTest": RegExp(r'([A-za-z]+) - ([A-za-z]+) (\d{4})'),
    "noOfPeriods": 2,
    "description": "Six-Monthly Period type test",
  },
  {
    "id": PeriodTypes.SIXMONTHLYAPR,
    "periodIdTest": RegExp(r'^([0-9]{4})AprilS([12])$'),
    "periodNameTest": RegExp(r'^([a-zA-Z]+)( | \d{4} )- ([a-zA-Z]+) \d{4}$'),
    "noOfPeriods": 2,
    "description": "Six-Monthly Period type test",
  },
  {
    "id": PeriodTypes.YEARLY,
    "periodIdTest": RegExp(r'^(\d{4})$'),
    "periodNameTest": RegExp(r'(\d{4})'),
    "noOfPeriods": 10,
    "description": "Yearly Period type test",
  },
  {
    "id": PeriodTypes.FYNOV,
    "description": "Financial Year November Period type test",
    "periodIdTest": RegExp(r'^([0-9]{4})Nov$'),
    "periodNameTest": RegExp(r'([A-za-z]+) (\d{4}) - ([A-za-z]+) (\d{4})'),
    "noOfPeriods": 10,
  },
  {
    "id": PeriodTypes.FYOCT,
    "description": "Financial Year October Period type test",
    "periodIdTest": RegExp(r'^([0-9]{4})Oct$'),
    "periodNameTest": RegExp(r'([A-za-z]+) (\d{4}) - ([A-za-z]+) (\d{4})'),
    "noOfPeriods": 10,
  },
  {
    "id": PeriodTypes.FYJUL,
    "description": "Financial Year July Period type test",
    "periodIdTest": RegExp(r'^([0-9]{4})July$'),
    "periodNameTest": RegExp(r'([A-za-z]+) (\d{4}) - ([A-za-z]+) (\d{4})'),
    "noOfPeriods": 10,
  },
  {
    "id": PeriodTypes.FYAPR,
    "description": "Financial Year April Period type test",
    "periodIdTest": RegExp(r'^([0-9]{4})April$'),
    "periodNameTest": RegExp(r'([A-za-z]+) (\d{4}) - ([A-za-z]+) (\d{4})'),
    "noOfPeriods": 10,
  }
];

List<Map<String, dynamic>> relativePeriodTests = [
  {
    "id": PeriodTypes.DAILY,
  },
  {
    "id": PeriodTypes.WEEKLY,
  },
  {
    "id": PeriodTypes.BIWEEKLY,
  },
  {
    "id": PeriodTypes.MONTHLY,
  },
  {
    "id": PeriodTypes.BIMONTHLY,
  },
  {
    "id": PeriodTypes.QUARTERLY,
  },
  {
    "id": PeriodTypes.SIXMONTHLY,
  },
  {
    "id": PeriodTypes.FINANCIAL,
  },
  {
    "id": PeriodTypes.YEARLY,
  },
];

void main() {
  for (int year in years) {
    group(
        "fixed period tests for year $year: ",
        () => {
              for (Map suite in fixedPeriodsTests)
                {
                  test(suite['description'], () {
                    PeriodType periodType =
                        PeriodType.fromId(suite['id'], year: year);
                    List<Period> periods = periodType.periods;
                    for (var period in periods) {
                      expect(
                          (suite['periodIdTest'] as RegExp).hasMatch(period.id),
                          isTrue);
                      expect(
                          (suite['periodNameTest'] as RegExp)
                              .hasMatch(period.name),
                          isTrue);
                    }
                  })
                }
            });
  }
  for (Map suite in relativePeriodTests) {
    test("", () {
      PeriodType periodType =
          PeriodType.fromId(suite['id'], category: PeriodTypeCategory.RELATIVE);
      expect(periodType.periods.length > 0, isTrue);
    });
  }
}
