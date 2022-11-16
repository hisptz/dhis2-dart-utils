// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `OperatorsConstants` is a collection of supported operators for different computations by the library
///
class OperatorsConstants {
  // This is a list of arithmetic operators supported by the library
  static List<String> arithmeticOperators = ['+', '-', '*', '/', '%'];

  // This is a list of all logical operators supported by the library
  static List<String> logicalOperators = [
    '>=',
    '===',
    '==',
    '<=',
    '!=',
    '&&',
    '!',
    '||',
    '>',
    '<',
  ];

  // This is a list of all supported DHIS2 operators
  static List<String> dhis2Operators = [
    'd2:condition',
    'd2:hasValue',
    'if',
    'isNull',
    'isNotNull'
  ];
}
