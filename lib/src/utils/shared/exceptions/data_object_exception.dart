// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `DataObjectException` is a class for exception handling during manipulation of form data object
///
class DataObjectException implements Exception {
  // This is a source of the exception
  final String source;

  /// The default constructor takes `source` as the only param
  DataObjectException(this.source);

  /// This is an override  `toString()`function for debugging
  @override
  String toString() {
    return 'DATA OBJECT EXCEPTION: $source';
  }
}
