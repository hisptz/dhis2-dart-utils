import 'period_categories.dart';
import 'period_types.dart';

List<Map<String, dynamic>> relativePeriodTypes = [
  {
    "id": PeriodTypes.daily,
    "getPeriods": () => getDaysPeriodType(),
    "name": 'Days',
    "category": PeriodTypeCategory.relative,
    "unit": "day"
  },
  {
    "id": PeriodTypes.weekly,
    "getPeriods": () => getWeeksPeriodType(),
    "name": 'Weeks',
    "category": PeriodTypeCategory.relative,
    "unit": 'week',
  },
  {
    "id": PeriodTypes.biWeekly,
    "getPeriods": () => getBiWeeksPeriodType(),
    "category": PeriodTypeCategory.relative,
    "name": 'Bi-weeks',
    "unit": "week"
  },
  {
    "id": PeriodTypes.monthly,
    "getPeriods": () => getMonthsPeriodType(),
    "name": 'Months',
    "category": PeriodTypeCategory.relative,
    "unit": "month",
  },
  {
    "id": PeriodTypes.biMonthly,
    "getPeriods": () => getBiMonthsPeriodType(),
    "name": 'Bi-months',
    "category": PeriodTypeCategory.relative,
    "unit": "month",
  },
  {
    "id": PeriodTypes.quarterly,
    "getPeriods": () => getQuartersPeriodType(),
    "name": 'Quarters',
    "category": PeriodTypeCategory.relative,
    "unit": "month"
  },
  {
    "id": PeriodTypes.sixMonthly,
    "getPeriods": () => getSixMonthsPeriodType(),
    "name": 'Six-months',
    "category": PeriodTypeCategory.relative,
    "unit": "month"
  },
  {
    "id": PeriodTypes.financial,
    "getPeriods": () => getFinancialYearsPeriodType(),
    "name": 'Financial Years',
    "category": PeriodTypeCategory.relative,
    "unit": "year"
  },
  {
    "id": PeriodTypes.yearly,
    "getPeriods": () => getYearsPeriodType(),
    "name": 'Years',
    "category": PeriodTypeCategory.relative,
    "unit": "year"
  },
];

getDaysPeriodType() => [
      {"id": 'TODAY', "name": 'Today'},
      {"id": 'YESTERDAY', "name": 'Yesterday'},
      {"id": 'LAST_3_DAYS', "name": 'Last 3 days'},
      {"id": 'LAST_7_DAYS', "name": 'Last 7 days'},
      {"id": 'LAST_14_DAYS', "name": 'Last 14 days'},
      {"id": 'LAST_30_DAYS', "name": 'Last 30 days'},
      {"id": 'LAST_60_DAYS', "name": 'Last 60 days'},
      {"id": 'LAST_90_DAYS', "name": 'Last 90 days'},
      {"id": 'LAST_180_DAYS', "name": 'Last 180 days'},
    ];

getWeeksPeriodType() => [
      {"id": 'THIS_WEEK', "name": 'This week'},
      {"id": 'LAST_WEEK', "name": 'Last week'},
      {"id": 'LAST_4_WEEKS', "name": 'Last 4 weeks'},
      {"id": 'LAST_12_WEEKS', "name": 'Last 12 weeks'},
      {"id": 'LAST_52_WEEKS', "name": 'Last 52 weeks'},
      {"id": PeriodTypes.weeksThisYear, "name": 'Weeks this year'},
    ];

getBiWeeksPeriodType() => [
      {"id": 'THIS_BIWEEK', "name": 'This bi-week'},
      {"id": 'LAST_BIWEEK', "name": 'Last bi-week'},
      {"id": 'LAST_4_BIWEEKS', "name": 'Last 4 bi-weeks'},
    ];

getMonthsPeriodType() => [
      {"id": 'THIS_MONTH', "name": 'This month'},
      {"id": 'LAST_MONTH', "name": 'Last month'},
      {"id": 'LAST_3_MONTHS', "name": 'Last 3 months'},
      {"id": 'LAST_6_MONTHS', "name": 'Last 6 months'},
      {"id": 'LAST_12_MONTHS', "name": 'Last 12 months'},
      {
        "id": 'MONTHS_THIS_YEAR',
        "name": 'Months this year',
      },
    ];

getBiMonthsPeriodType() => [
      {"id": 'THIS_BIMONTH', "name": 'This bi-month'},
      {"id": 'LAST_BIMONTH', "name": 'Last bi-month'},
      {
        "id": 'LAST_6_BIMONTHS',
        "name": 'Last 6 bi-months',
      },
      {
        "id": 'BIMONTHS_THIS_YEAR',
        "name": 'Bi-months this year',
      },
    ];

getQuartersPeriodType() => [
      {"id": 'THIS_QUARTER', "name": 'This quarter'},
      {"id": 'LAST_QUARTER', "name": 'Last quarter'},
      {"id": 'LAST_4_QUARTERS', "name": 'Last 4 quarters'},
      {
        "id": 'QUARTERS_THIS_YEAR',
        "name": 'Quarters this year',
      },
    ];

getSixMonthsPeriodType() => [
      {"id": 'THIS_SIX_MONTH', "name": 'This six-month'},
      {"id": 'LAST_SIX_MONTH', "name": 'Last six-month'},
      {
        "id": 'LAST_2_SIXMONTHS',
        "name": 'Last 2 six-month',
      },
    ];

getFinancialYearsPeriodType() => [
      {
        "id": 'THIS_FINANCIAL_YEAR',
        "name": 'This financial year',
      },
      {
        "id": 'LAST_FINANCIAL_YEAR',
        "name": 'Last financial year',
      },
      {
        "id": 'LAST_5_FINANCIAL_YEARS',
        "name": 'Last 5 financial years',
      },
    ];

getYearsPeriodType() => [
      {"id": 'THIS_YEAR', "name": 'This year'},
      {"id": 'LAST_YEAR', "name": 'Last year'},
      {"id": 'LAST_5_YEARS', "name": 'Last 5 years'},
      {"id": 'LAST_10_YEARS', "name": 'Last 10 years'},
    ];
