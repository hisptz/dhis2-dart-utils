// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `Dhis2TeiRelationship` is a data model class for the DHIS2 TEI releationship metadata
///
class Dhis2TeiRelationship {
  /// This is a DHIS2 uid for a given TEI relationship
  String? id;

  /// This is a DHIS2 uid for a given TEI relationship type
  String? relationshipType;

  /// This is a DHIS2 uid for a given TEI from in relationship for a given TEI
  String? fromTei;

  /// This is a DHIS2 uid for a given TEI to in relationship for a given TEI
  String? toTei;

  ///  This is the offline synchronization status for an event
  ///  It holds two values, `synced` and `not-synced`
  String? syncStatus;

  /// This is the default constructor for the `Dhis2TeiRelationship`
  Dhis2TeiRelationship({
    this.id,
    this.fromTei,
    this.relationshipType,
    this.toTei,
    this.syncStatus,
  });

  /// This is a getter for the offline `syncStatus` of a `Dhis2TeiRelationship`
  bool get isSynced => syncStatus == "synced";

  /// `Dhis2TeiRelationship.fromJson` is a factory constructor that generated a `Dhis2TeiRelationship` from a `dynamic` json

  factory Dhis2TeiRelationship.fromJson(dynamic json) {
    Map from = json['from'] ?? {};
    Map fromTrackedEntityInstance = from['trackedEntityInstance'] ?? {};
    String fromTei = fromTrackedEntityInstance['trackedEntityInstance'] ?? '';
    Map to = json['to'] ?? {};
    Map toTrackedEntityInstance = to['trackedEntityInstance'] ?? {};
    String toTei = toTrackedEntityInstance['trackedEntityInstance'] ?? '';
    return Dhis2TeiRelationship(
      id: json['relationship'],
      syncStatus: json['syncStatus'] ?? 'synced',
      fromTei: fromTei,
      relationshipType: json['relationshipType'],
      toTei: toTei,
    );
  }

  /// `Dhis2TeiRelationship.toJson` is a method that converts the `Dhis2TeiRelationship` to a `Map` object reperesantation of origina relationShip payload
  Map toJson() {
    Map data = <String, dynamic>{};
    data['relationshipType'] = relationshipType;
    data['relationship'] = id;
    data['syncStatus'] = syncStatus;
    Map from = <String, dynamic>{};
    Map fromTrackedEntityInstance = {'trackedEntityInstance': fromTei};
    from['trackedEntityInstance'] = fromTrackedEntityInstance;
    Map to = <String, dynamic>{};
    Map toTrackedEntityInstance = {'trackedEntityInstance': toTei};
    to['trackedEntityInstance'] = toTrackedEntityInstance;
    data['from'] = from;
    data['to'] = to;
    return data;
  }

  /// `Dhis2TeiRelationship.toMap` is a method that converts the `Dhis2TeiRelationship` to a `Map` object
  Map<String, dynamic> toMap() {
    var mapData = <String, dynamic>{};
    mapData['id'] = id;
    mapData['relationshipType'] = relationshipType;
    mapData['fromTei'] = fromTei;
    mapData['toTei'] = toTei;
    mapData['syncStatus'] = syncStatus;
    return mapData;
  }

  /// `Dhis2Event.fromMap` is a constructor that generated a `Dhis2Event` from a `Map` object
  Dhis2TeiRelationship.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    relationshipType = mapData['relationshipType'];
    fromTei = mapData['fromTei'];
    toTei = mapData['toTei'];
    syncStatus = mapData['syncStatus'];
  }

  /// This is the `toString()` method that return the string representation of the `Dhis2TeiRelationship`
  @override
  String toString() {
    return 'from $fromTei to $toTei';
  }
}
