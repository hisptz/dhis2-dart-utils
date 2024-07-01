// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

//
// This is the exception handler for the program indicator
//
class ProgramIndicatorException implements Exception {
  //
  // This is the source for the exception as description to what went wrong
  //
  final String source;

  //
  // This is the constructor to the `ProgramIndicatorException`
  //
  ProgramIndicatorException(this.source);

  @override
  String toString() {
    return 'PROGRAM INDICATOR EXCEPTION: $source';
  }
}
