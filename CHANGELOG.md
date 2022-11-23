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
