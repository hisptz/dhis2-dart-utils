## 1.1.25

- Removed the unused packages
  - flutter_map

## 1.1.24

- Updated package dependencies

## 1.1.23

- Bugfix: fixed the fromMap and toMap constructors for the DHIS2 organisation unit model

## 1.1.22

- Improvement: Added the geometry attribute to the DHIS2 organisation unit model

## 1.1.21

- Bugfix: fixed the misspelled variables on the events, enrollment and tracked entity instance for capturing location in geometry formats

## 1.1.20

- Improvement: Improvement on the models for DHIS2 events, enrollments and tracked entity instance
  - Added coordinate attribute that stringifies the geometry object given that it's of type Point

## 1.1.19

- Improvement:updated the README's util features section.

## 1.1.18

- Added HTTP request support with token authorization, enabling seamless communication with external APIs and providing enhanced security through Personal Access Tokens.

## 1.1.17

- Improvement: improved the performance of decoding of program rule variables

## 1.1.16

- Improvement: improved the program rule evaluations by:
  - Supporting sorting of program rules by priorities
  - Implemented casting of 1's and 0's on the logical operations with boolean values
  - Fixed the bugs with logical operators in the program rules evaluations

## 1.1.15

- Bugfix: fixed the bug with d2:hasValue operator and boolean handling

## 1.1.14

- Bugfix: fixed the targeting of the data items that are affected by the program rules

## 1.1.13

- Added d2 mathematical operators
  - d2:modulus
  - d2:ceil
  - d2:floor
  - d2:round

## 1.1.12

- Performance improvement on Program rule evaluation
  - Improved the Performance of the program rule engine by moving the evaluation program rule condition to be done on each program rule rather than each action

## 1.1.11

- Bugfix: Program rule evaluations:
  - Fixed the issues with decoding of program rule variables
  - Fixed the evaluation of joint operators such as && and ||

## 1.1.10

- Enhancement of program rule evaluations
  - Added support for date evaluation program rules for:
    - Years Between
    - Months Between
    - Weeks Between
    - Days Between

## 1.1.9

- Enhancement on enrollment data model transformation

## 1.1.8

- Bugfix: Program rule engine failures:
  - Fixed the bug caused by DHIS2 2.38 and above where program rules could assign values within single and double quotes.
    - The fix involved additional sanitization of the values before auto-assignment

## 1.1.7

- Bugfix: Program rule engine failures:
  - Fixed the assignment of data id (either data element or tracked entity attribute) after evaluation of program rules expression before performing program rule actions.

## 1.1.6

- Bugfix: Program rule engine failures:
  - Fixed the bug with .

## 1.1.5

- Model fixing for type casting in Dhis2Organization fromJson function

## 1.1.4

- Bugfix: Program rule engine failures:
  - Added support of decoding attributes and variables in the program rule expression.

## 1.1.3

- Model fixing for assignment of default value on fromJson function

## 1.1.2

- Model improvement for TEIs
- Improvements on models classes

## 1.1.1

- Add default values for created and last update timestamps
- Improvement for Dhis2 enrollment data model
- Documentation for models classes

## 1.1.0

- Add data model for TEIs (Tracked entity Instance, relationships, tracked entity attributes)
- Improvement for event based data models

## 1.0.4

- Bugfix
  - Fixed the evaluation of the mathematical operations.
    - This fixed the bug with program rule evaluation.

## 1.0.3

- improved the DHIS data model for Event Data values
  - Added created and lastUpdated fields
- Removed unused dependencies

## 1.0.2

- Support for DHIS2 data models
  - Event
  - Event Data Value
  - Data Elements
  - Option
  - Organisation unit
  - System info

## 1.0.1

- Support for additional operators such as:
  - NOT(!)
  - d2:hasValue
  - isNull
  - isNotNull
- Added recursive evaluation of d2 functions in expressions
- Handled exceptions without blocking engine's processes
- Escaped the String escaped characters during expression evaluation
- Added file level dartdoc

## 1.0.0

- Support for Program rule engine implementation for form data objects.
- Support for Program indicator engine implementation for form data objects.
- Improved the period utility by exporting period constants supported in DHIS2.
- Improvement on examples and package documentation.

## 1.0.0-alpha-1

### Initial release

- Support core utility for generation of DHIS2 uids.
- Support for DHIS2 periods, period types and utilities.
