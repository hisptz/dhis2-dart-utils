// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `StringHelpers` is a collection of custom helper functions for manipulating `String`
///
class StringHelpers {
  ///
  /// `StringHelpers.escapeCharacter` is a method that escapes specified characters from a `String` to return a
  /// The method accepts a `String` to be sanitized and a list of `String` characters to be escaped as parameters, and returns a sanitized `String`
  ///  ```dart
  ///  String val = "Hello\n\"";
  ///  val = StringHelpers.escapeCharacter(val, escapeChar: ["\n", "\""]); // this makes val = "Hello"
  /// ```
  ///
  static String escapeCharacter(
    String string, {
    List<String> escapeChar = const [],
  }) {
    for (String char in escapeChar) {
      string = string.replaceAll(char, '');
    }
    return string;
  }
}
