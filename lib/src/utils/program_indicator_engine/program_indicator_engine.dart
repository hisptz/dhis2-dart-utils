// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'helpers/program_indicator_helper.dart';
import 'models/program_indicator.dart';

///
/// `ProgramIndicatorEngine` is the engine class for evaluating the program indicators
///
class ProgramIndicatorEngine {
  ///
  /// This is the static method for evaluation of program indicators on the given form data object
  ///  `ProgramIndicatorEngine.evaluateProgramIndicators` takes in a `List<ProgramIndicator>` and a `Map` of form data object.
  ///   It returns the new `Map` of form data object with the evaluated values
  ///
  static Map evaluateProgramIndicators(
      {required List<ProgramIndicator> programIndicators,
      Map dataObject = const {}}) {
    Map evaluatedValues = {};
    for (ProgramIndicator programIndicator in programIndicators) {
      String value =
          ProgramIndicatorHelper.evaluateExpressionValueFromProgramIndicator(
              programIndicator: programIndicator, dataObject: dataObject);
      evaluatedValues[programIndicator.id] = value;
    }
    return evaluatedValues;
  }
}
