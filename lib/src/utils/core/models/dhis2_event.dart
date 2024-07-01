// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dhis2_dart_utils/src/utils/core/helpers/coordinates_helpers.dart';

import 'dhis2_event_data_value.dart';

//
// `Dhis2Event` is a data model class for the DHIS2 Event metadata
//
class Dhis2Event {
  // This is a DHIS2 uid for a given event
  // It is used if needed to have it events have to alteratively to conform to other platform metadata structure
  String? id;

  // This is a DHIS2 uid for a given event
  String? event;

  // This is a DHIS2 uid for a given trackedEntityInstance
  String? trackedEntityInstance;

  // This is a string representation of a date when the `Dhis2Event` occured
  // It conforms to the structure `YYYY-MM-DD`
  String? eventDate;

  // This is the DHIS2 id for the `Dhis2OrganisationUnit` to which the event occured
  String? orgUnit;

  // This is the DHIS2 id for the Program to which a given event belongs
  String? program;

  // This is the DHIS2 id for the Program stage to which a given event belongs
  String? programStage;

  // This is the DHIS2 username for a user who registered the event
  String? storedBy;

  // This is the date to which the DHIS2 status of an event turned to `COMPLETED`
  // `completedDate` is formatted to `date ISO` string in form like `YYYY-MM-DDT...`
  String? completedDate;

  // This is a DHIS2 defined status for an event
  // Status could be `ACTIVE`, `SCHEDULED` or `COMPLETED`
  String? status;

  //  This is the offline synchronization status for an event
  //  It holds two values, `synced` and `not-synced`
  String? syncStatus;

  // This is the coordinate for the event
  // It is formatted as `latitude,longitude`
  String? coordinate;

  //  This is the list of `Dhis2EventDataValue` associated with the event
  List<Dhis2EventDataValue>? dataValues;

  // This is the default constructor for the `Dhis2Event`
  Dhis2Event({
    required this.event,
    required this.eventDate,
    required this.orgUnit,
    required this.program,
    required this.programStage,
    required this.status,
    this.trackedEntityInstance = '',
    this.storedBy = '',
    this.completedDate = '',
    this.syncStatus = 'synced',
    this.coordinate = '',
    this.dataValues = const [],
  }) {
    id = event;
  }

  // This is a getter for the offline `syncStatus` of a `Dhis2Event`
  bool get isSynced => syncStatus == "synced";

  // `Dhis2Event.toMap` is a method that converts the `Dhis2Event` to a `Map` object
  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['event'] = event;
    data['trackedEntityInstance'] = trackedEntityInstance;
    data['eventDate'] = eventDate;
    data['orgUnit'] = orgUnit;
    data['program'] = program;
    data['programStage'] = programStage;
    data['status'] = status;
    data['storedBy'] = storedBy;
    data['completedDate'] = completedDate;
    data['syncStatus'] = syncStatus;
    data['coordinate'] = coordinate;
    return data;
  }

  // `Dhis2Event.fromMap` is a constructor that generated a `Dhis2Event` from a `Map` object
  Dhis2Event.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    event = mapData['event'];
    trackedEntityInstance = mapData['trackedEntityInstance'] ?? '';
    eventDate = (mapData['eventDate'] ?? '').split('T')[0];
    orgUnit = mapData['orgUnit'] ?? '';
    program = mapData['program'] ?? '';
    programStage = mapData['programStage'] ?? '';
    status = mapData['status'] ?? '';
    storedBy = mapData['storedBy'] ?? '';
    completedDate = (mapData['completedDate'] ?? '').split('T')[0];
    syncStatus = mapData['syncStatus'] ?? '';
    dataValues = mapData['dataValues'] ?? [];
    coordinate = mapData['coordinate'] ?? '';
  }

  // `Dhis2Event.fromJson` is a factory constructor that generated a `Dhis2Event` from a `dynamic` json
  factory Dhis2Event.fromJson(
    dynamic json,
  ) {
    String event = json['event'] ?? '';
    return Dhis2Event(
      event: event,
      trackedEntityInstance: json['trackedEntityInstance'] ?? '',
      eventDate: json['eventDate'] ?? '',
      orgUnit: json['orgUnit'] ?? '',
      program: json['program'] ?? '',
      programStage: json['programStage'] ?? '',
      status: json['status'] ?? '',
      storedBy: json['storedBy'] ?? '',
      completedDate: json['completedDate'] ?? '',
      syncStatus: json['syncStatus'] ?? 'synced',
      dataValues: getDataValues(json, event),
      coordinate: json['coordinate'] != null
          ? CoordinatesHelpers.getStringifiedCoordinatesFromCoordinatesObject(
              json['coordinate'])
          : CoordinatesHelpers.getStringifiedCoordinatesFromGeometry(
              json['geometry'] ?? {},
            ),
    );
  }

  // This is a method that gets a `List` of all `Dhis2EventDataValue` associate with a given `Dhis2Event`
  // The method accepts a `dynamic` event json and `String` id for the event
  // The method return a `List<Dhis2EventDataValue>`
  static List<Dhis2EventDataValue> getDataValues(dynamic json, String eventId) {
    List<Dhis2EventDataValue> dhis2DataValues = [];
    try {
      for (dynamic dataValueJson in json['dataValues'] ?? []) {
        dhis2DataValues.add(Dhis2EventDataValue.fromJson(
          dataValueJson,
          eventId,
        ));
      }
    } catch (error) {
      //
    }
    return dhis2DataValues;
  }

  // This is the `toString()` method that return the string representation of the `Dhis2Event`
  @override
  String toString() {
    return '$event $eventDate';
  }
}
