// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `Dhis2Enrollment` is a data model class for the DHIS2 enrollment metadata
///
class Dhis2Enrollment {
  /// This is a DHIS2 uid for a given enrollment
  String? enrollment;

  /// This is a string representation of a date when the `Dhis2Enrollment` occured
  /// It conforms to the structure `YYYY-MM-DD`
  String? enrollmentDate;

  /// This is a string representation of a date when the `Dhis2Enrollment` occured
  /// It conforms to the structure `YYYY-MM-DD`
  String? incidentDate;

  /// This is the DHIS2 id for the Program to which a given enrollment belongs
  String? program;

  /// This is the DHIS2 id for the `Dhis2OrganisationUnit` to which the enrollment occured
  String? orgUnit;

  /// This is a DHIS2 uid for a given trackedEntityInstance
  String? trackedEntityInstance;

  /// This is a DHIS2 defined status for an enrollment
  /// Status could be `ACTIVE`,  or `COMPLETED`
  String? status;

  ///  This is the offline synchronization status for an enrollment
  ///  It holds two values, `synced` and `not-synced`
  String? syncStatus;

  /// This is the time for creation of the `Dhis2Enrollment`
  String? created;

  /// This is the time stamp for the last updating time of the `Dhis2Enrollment`
  String? lastUpdated;

  // This String value in case of searching ceriterial for TEI throug enrollment
  String? searchableValue;

  /// This is the default constructor for the `Dhis2Enrollment`
  Dhis2Enrollment({
    this.enrollment,
    this.enrollmentDate,
    this.incidentDate,
    this.program,
    this.orgUnit,
    this.trackedEntityInstance,
    this.status,
    this.created,
    this.lastUpdated,
    this.syncStatus = 'synced',
    this.searchableValue = '',
  });

  /// This is a getter for the offline `syncStatus` of a `Dhis2Enrollment`
  bool get isSynced => syncStatus == "synced";

  /// `Dhis2Enrollment.toMap` is a method that converts the `Dhis2Enrollment` to a `Map` object
  Map<String, dynamic> toMap() {
    var now = DateTime.now().toIso8601String();
    var data = <String, dynamic>{};
    data['enrollment'] = enrollment;
    data['enrollmentDate'] = enrollmentDate;
    data['incidentDate'] = incidentDate;
    data['program'] = program;
    data['orgUnit'] = orgUnit;
    data['trackedEntityInstance'] = trackedEntityInstance;
    data['status'] = status;
    data['syncStatus'] = syncStatus;
    data['searchableValue'] = searchableValue;
    data['created'] = created ?? now;
    data['lastUpdated'] = lastUpdated ?? now;
    return data;
  }

  /// `Dhis2Enrollment.fromMap` is a constructor that generated a `Dhis2Enrollment` from a `Map` object
  Dhis2Enrollment.fromMap(Map<String, dynamic> mapData) {
    enrollment = mapData['enrollment'];
    enrollmentDate = mapData['enrollmentDate'];
    incidentDate = mapData['incidentDate'];
    program = mapData['program'];
    orgUnit = mapData['orgUnit'];
    trackedEntityInstance = mapData['trackedEntityInstance'];
    status = mapData['status'];
    syncStatus = mapData['syncStatus'];
    searchableValue = mapData['searchableValue'];
    created = mapData['created'];
    lastUpdated = mapData['lastUpdated'];
  }

  /// `Dhis2Enrollment.fromJson` is a factory constructor that generated a `Dhis2Enrollment` from a `dynamic` json

  factory Dhis2Enrollment.fromJson(dynamic json) {
    var now = DateTime.now().toIso8601String();
    return Dhis2Enrollment(
        enrollment: json['enrollment'] ?? '',
        enrollmentDate: "${json['enrollmentDate']}".split('T')[0],
        incidentDate: "${json['incidentDate']}".split('T')[0],
        program: json['program'],
        orgUnit: json['orgUnit'],
        trackedEntityInstance: json['trackedEntityInstance'],
        syncStatus: json['syncStatus'] ?? 'synced',
        status: json['status'],
        created: json['created'] ?? now,
        lastUpdated: json['lastUpdated'] ?? now,
        searchableValue: json['searchableValue'] ?? '');
  }

  /// This is the `toString()` method that return the string representation of the `Dhis2Enrollment`
  @override
  String toString() {
    return 'trackedEntityInstance : $trackedEntityInstance on enrollment :$enrollment';
  }
}
