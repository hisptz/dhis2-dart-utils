## 1.1.4
- Model fixing for type casting in Dhis2Organization fromJson function
## 1.1.3

- Model fixing for assignment of default value on fromJson function

## 1.1.2

- Model improvement for TEIs
- Improvements on models classess

## 1.1.1

- Add default values for created and last update timestamps
- Improvement for Dhis2 enrollemnt data model
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
