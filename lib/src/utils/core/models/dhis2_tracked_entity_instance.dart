// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dhis2_dart_utils/src/utils/core/helpers/coordinates_helpers.dart';

import 'dhis2_tracked_entity_instance_value.dart';

//
// `Dhis2TrackedEntityInstance` is a data model class for the DHIS2 TEIs metadata
//
class Dhis2TrackedEntityInstance {
  // This is a DHIS2 uid for a given trackedEntityInstance
  String? trackedEntityInstance;

  // This is a DHIS2 uid for a given tracked entity type for trackedEntityInstance
  String? trackedEntityType;

  // This is the DHIS2 id for the `Dhis2OrganisationUnit` to which the event occured
  String? orgUnit;

  // This is the coordinate for the tracked entity instance
  // It is formatted as `latitude,longitude`
  String? coordinate;

  //  This is the list of `Dhis2TrackedEntityInstanceValue` associated with the TrackedEntityInstance
  List<Dhis2TrackedEntityInstanceValue>? attributes;

  //  This is the offline synchronization status for an event
  //  It holds two values, `synced` and `not-synced`
  String? syncStatus;

  Dhis2TrackedEntityInstance({
    required this.trackedEntityInstance,
    required this.trackedEntityType,
    required this.orgUnit,
    this.attributes = const [],
    this.syncStatus = 'synced',
    this.coordinate = '',
  });

  // This is a getter for the offline `syncStatus` of a `Dhis2TrackedEntityInstance`
  bool get isSynced => syncStatus == "synced";

  // `Dhis2TrackedEntityInstance.toMap` is a method that converts the `Dhis2TrackedEntityInstance` to a `Map` object
  Map<String, dynamic> toMap() {
    var mapData = <String, dynamic>{};
    mapData['trackedEntityInstance'] = trackedEntityInstance;
    mapData['trackedEntityType'] = trackedEntityType;
    mapData['orgUnit'] = orgUnit;
    mapData['syncStatus'] = syncStatus;
    mapData['attributes'] = attributes;
    mapData['coordinate'] = coordinate;
    return mapData;
  }

  // `Dhis2TrackedEntityInstance.fromMap` is a constructor that generated a `Dhis2TrackedEntityInstance` from a `Map` object
  Dhis2TrackedEntityInstance.fromMap(Map<String, dynamic> mapData) {
    trackedEntityInstance = mapData['trackedEntityInstance'] ?? '';
    trackedEntityType = mapData['trackedEntityType'] ?? '';
    orgUnit = mapData['orgUnit'] ?? '';
    syncStatus = mapData['syncStatus'] ?? '';
    attributes = mapData['attributes'] ?? [];
    coordinate = mapData['coordinate'] ?? '';
  }

  // `Dhis2TrackedEntityInstance.fromJson` is a factory constructor that generated a `Dhis2TrackedEntityInstance` from a `dynamic` json
  factory Dhis2TrackedEntityInstance.fromJson(dynamic json) {
    String trackedEntityInstanceId = json['trackedEntityInstance'] ?? '';
    return Dhis2TrackedEntityInstance(
      trackedEntityInstance: trackedEntityInstanceId,
      syncStatus: json['syncStatus'] ?? 'synced',
      trackedEntityType: json['trackedEntityType'] ?? '',
      orgUnit: json['orgUnit'] ?? '',
      attributes: getAttributeValues(json, trackedEntityInstanceId),
      coordinate: json['coordinate'] != null
          ? CoordinatesHelpers.getStringifiedCoordinatesFromCoordinatesObject(
              json['coordinate'])
          : CoordinatesHelpers.getStringifiedCoordinatesFromGeometry(
              json['geometry'] ?? {},
            ),
    );
  }

  // This is a method that gets a `List` of all `Dhis2TrackedEntityInstanceValue` associate with a given `Dhis2TrackedEntityInstance`
  // The method accepts a `dynamic` attribute json and `String` id for the TEI
  // The method return a `List<Dhis2TrackedEntityInstanceValue>`
  static List<Dhis2TrackedEntityInstanceValue> getAttributeValues(
    dynamic json,
    String trackedEntityInstanceId,
  ) {
    List<Dhis2TrackedEntityInstanceValue> dhis2AttributeValues = [];
    try {
      for (dynamic attributeValueJson in json['attributes'] ?? []) {
        dhis2AttributeValues.add(Dhis2TrackedEntityInstanceValue.fromJson(
          attributeValueJson,
          trackedEntityInstanceId,
        ));
      }
    } catch (error) {
      //
    }
    return dhis2AttributeValues;
  }

  // This is the `toString()` method that return the string representation of the `Dhis2TeiRelationship`
  @override
  String toString() {
    return 'trackedEntityInstance $trackedEntityInstance';
  }
}
