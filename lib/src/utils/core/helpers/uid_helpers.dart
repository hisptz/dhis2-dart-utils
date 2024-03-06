// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

// Collection of helpers for generation of DHIS2 uid
// The class exposes a single static method `generateUid() `that generates the random id

class UidHelpers {
  // This is a method for generating random uids with DHIS2 requirements
  // Uid returned needs to be of 11  alphanumeric character length starting with an alphabet
  // ```dart
  // var uid = UidHelpers.generateUid(); // uid will be the random DHI2 uid of 11 characters length
  //
  // ```
  //
  static String generateUid() {
    Random rnd = Random();
    const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const allowedChars = '0123456789$letters';
    const numberOfCodePoints = allowedChars.length;
    const codeSize = 11;
    String uid = '';
    int charIndex = (rnd.nextInt(10) / 10 * letters.length).round();
    uid = letters.substring(charIndex, charIndex + 1);
    for (int i = 1; i < codeSize; ++i) {
      charIndex = (rnd.nextInt(10) / 10 * numberOfCodePoints).round();
      uid += allowedChars.substring(charIndex, charIndex + 1);
    }
    return uid;
  }
}
