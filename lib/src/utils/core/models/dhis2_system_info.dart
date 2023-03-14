// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `Dhis2SystemInfo` is a data model class for the DHIS2 System info metadata
///
class Dhis2SystemInfo {
  /// this is the DHIS2 context path
  String? contextPath;

  /// this is the DHIS2 system Id
  String? systemId;

  /// this is the DHIS2 system name
  String? systemName;

  /// this is the DHIS2 user Agent
  String? userAgent;

  /// this is the calender that is configured on the DHIS2 instance
  String? calendar;

  /// this is the date format for the DHIS2 instance
  String? dateFormat;

  /// this is the `date ISO` string representation of the last time a DHIS2 analytics table was created successful
  String? lastAnalyticsTableSuccess;

  /// this is the string representation of the duration it took to create the last DHIS2 analytics table was created
  String? lastAnalyticsTableRuntime;

  /// this is a version of DHIS2
  String? version;

  /// this is revision of the DHIS2
  String? revision;

  /// this is the jasper Reports version as on DHIS2 instance
  String? jasperReportsVersion;

  // this is the DHIS2 environment variable
  String? environmentVariable;

  /// this is a DHIS2 file store provider
  String? fileStoreProvider;

  /// this is the DHIS2 instance read only mode
  String? readOnlyMode;

  /// this is the DHIS2 java version
  String? javaVersion;

  /// this is the DHIS2 instance operating system name
  String? osName;

  /// this is the DHIS2 instance operating system architecture
  String? osArchitecture;

  /// this is the DHIS2 instance operating system version
  String? osVersion;

  /// this is the DHIS2 memory information
  String? memoryInfo;

  /// this is the DHIS2 instance CPU cores
  String? cpuCores;

  /// this is the default constructor for the `Dhis2SystemInfo`
  Dhis2SystemInfo({
    this.contextPath,
    this.systemId,
    this.systemName,
    this.userAgent,
    this.calendar,
    this.dateFormat,
    this.lastAnalyticsTableSuccess,
    this.lastAnalyticsTableRuntime,
    this.version,
    this.revision,
    this.jasperReportsVersion,
    this.environmentVariable,
    this.fileStoreProvider,
    this.readOnlyMode,
    this.javaVersion,
    this.osName,
    this.osArchitecture,
    this.osVersion,
    this.memoryInfo,
    this.cpuCores,
  });

  /// `Dhis2SystemInfo.toMap` is a method that converts the `Dhis2SystemInfo` to a `Map` object
  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};

    data['contextPath'] = contextPath;
    data['systemId'] = systemId;
    data['systemName'] = systemName;
    data['userAgent'] = userAgent;
    data['calendar'] = calendar;
    data['dateFormat'] = dateFormat;
    data['lastAnalyticsTableSuccess'] = lastAnalyticsTableSuccess;
    data['lastAnalyticsTableRuntime'] = lastAnalyticsTableRuntime;
    data['version'] = version;
    data['revision'] = revision;
    data['jasperReportsVersion'] = jasperReportsVersion;
    data['environmentVariable'] = environmentVariable;
    data['fileStoreProvider'] = fileStoreProvider;
    data['readOnlyMode'] = readOnlyMode;
    data['javaVersion'] = javaVersion;
    data['osName'] = osName;
    data['osArchitecture'] = osArchitecture;
    data['osVersion'] = osVersion;
    data['memoryInfo'] = memoryInfo;
    data['cpuCores'] = cpuCores;

    return data;
  }

  /// `Dhis2SystemInfo.fromMap` is a constructor that generated a `Dhis2SystemInfo` from a `Map` object
  Dhis2SystemInfo.fromMap(Map<String, dynamic> map) {
    contextPath = map['contextPath'];
    systemId = map['systemId'];
    systemName = map['systemName'];
    userAgent = map['userAgent'];
    calendar = map['calendar'];
    dateFormat = map['dateFormat'];
    lastAnalyticsTableSuccess = map['lastAnalyticsTableSuccess'];
    lastAnalyticsTableRuntime = map['lastAnalyticsTableRuntime'];
    version = map['version'];
    revision = map['revision'];
    jasperReportsVersion = map['jasperReportsVersion'];
    environmentVariable = map['environmentVariable'];
    fileStoreProvider = map['fileStoreProvider'];
    readOnlyMode = map['readOnlyMode'];
    javaVersion = map['javaVersion'];
    osName = map['osName'];
    osArchitecture = map['osArchitecture'];
    osVersion = map['osVersion'];
    memoryInfo = map['memoryInfo'];
    cpuCores = map['cpuCores'];
  }

  /// `Dhis2SystemInfo.fromJson` is a factory constructor that generated a `Dhis2SystemInfo` from a `dynamic` json
  factory Dhis2SystemInfo.fromJson(dynamic json) {
    return Dhis2SystemInfo(
      contextPath: json['contextPath'] ?? '',
      systemId: json['systemId'] ?? '',
      systemName: json['systemName'] ?? '',
      userAgent: json['userAgent'] ?? '',
      calendar: json['calendar'] ?? '',
      dateFormat: json['dateFormat'] ?? '',
      lastAnalyticsTableSuccess: json['lastAnalyticsTableSuccess'] ?? '',
      lastAnalyticsTableRuntime: json['lastAnalyticsTableRuntime'] ?? '',
      version: json['version'] ?? '',
      revision: json['revision'] ?? '',
      jasperReportsVersion: json['jasperReportsVersion'] ?? '',
      environmentVariable: json['environmentVariable'] ?? '',
      fileStoreProvider: json['fileStoreProvider'] ?? '',
      readOnlyMode: json['readOnlyMode'] ?? '',
      javaVersion: json['javaVersion'] ?? '',
      osName: json['osName'] ?? '',
      osArchitecture: json['osArchitecture'] ?? '',
      osVersion: json['osVersion'] ?? '',
      memoryInfo: json['memoryInfo'] ?? '',
      cpuCores: "${json['cpuCores'] ?? ''}",
    );
  }

  /// this is the `toString()` method that return the string representation of the `Dhis2SystemInfo`
  @override
  String toString() {
    return '<$systemId $systemName>';
  }
}
