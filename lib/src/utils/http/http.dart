// Copyright (c) 2022, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;

// The HttpService class contains different DHIS2 http service functions
//
//
class HttpService {
  //This is the Username of the authorized account of the DHIS2 Instance
  String? username;

  //This is the Password of the authorized account of the DHIS2 Instance
  String? password;

  //This is the Server Url of the authorized account of the DHIS2 Instance
  String serverUrl;

  //This is the String of Basic Authorization of the account of the DHIS2 Instance
  String? basicAuth;

  //This is the String of Basic Authorization of the account of the DHIS2 Instance
  String? apiToken;

//This is the Constructor of the HttpService Class
  HttpService(
      {this.username, this.password, required this.serverUrl, this.apiToken});

//This function generates an Authorization Header
//Depending on the provided inputs, It returns either a Api Token or a Basic Authentication
//High Priority is given to Api Token Authentication
  String _getAuthorizationHeader() {
    return apiToken != null
        ? 'ApiToken ${apiToken!}'
        : 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  }

//This function creates a domainPath with proper syntax
  //This method accepts serverUrl and returns a String
  String get domainPath {
    return serverUrl
        .replaceAll('https://', '')
        .replaceAll('http://', '')
        .split('/')
        .where((domain) => domain != domainHost && domain.isNotEmpty)
        .toList()
        .join('/');
  }

//This function creates a domainHost with proper syntax
//This method accepts serverUrl and returns a String
  String get domainHost {
    return serverUrl
        .replaceAll('https://', '')
        .replaceAll('http://', '')
        .split('/')
        .first;
  }

  //This is the function that generates the final api url used to access DHIS2 resources
  //This method accepts url as String and queryParameters as a Map and returns a uri instance
  Uri getApiUrl(String url, {Map<String, dynamic>? queryParameters}) {
    url = domainPath == '' ? url : '$domainPath/$url';
    return Uri.https(domainHost, url, queryParameters);
  }

//This is the function that sends a Post Request to the DHIS2 Instance
//The function creates a new entity in the DHIS2 Instance Server
//This method accepts url String, query parameters, body of Json data and retuns a response object
  Future<http.Response> httpPost(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return http.post(
      apiUrl,
      headers: {
        'Authorization': _getAuthorizationHeader(),
        'Content-Type': 'application/json',
      },
      body: body,
    );
  }

//This is the function that sends a Put Request to the DHIS2 Instance with a JSON body
//The function updates an existing entity in the DHIS2 Instance Server
//This method accepts url String, query parameters, body of Json data and retuns a response object
  Future<http.Response> httpPut(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return http.put(
      apiUrl,
      headers: {
        'Authorization': _getAuthorizationHeader(),
        'Content-Type': 'application/json',
      },
      body: body,
    );
  }

//This is the function that sends a Delete Request to the DHIS2 Instance
//The function deletes an existing entity in the DHIS2 Instance Server
//This method accepts url String, query parameters and returns a response object
  Future<http.Response> httpDelete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return await http.delete(apiUrl, headers: {
      'Authorization': _getAuthorizationHeader(),
    });
  }

//This is the function that sends a Get Request to the DHIS2 Instance
//The function Reads entities in the DHIS2 Instance Server
//This method accepts url String, query parameters and returns a response object
  Future<http.Response> httpGet(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return await http.get(apiUrl, headers: {
      'Authorization': _getAuthorizationHeader(),
    });
  }

//This is the function that sends a Get Request to the DHIS2 Instance
//The function Reads entities in the DHIS2 Instance Server
  //This method accepts url String, query parameters and returns a response object with a page size of 1
  Future<http.Response> httpGetPagination(
    String url,
    Map<String, dynamic> queryParameters,
  ) async {
    Map<String, dynamic> dataQueryParameters = {
      'totalPages': 'true',
      'pageSize': '1',
      'fields': 'none',
    };
    dataQueryParameters.addAll(queryParameters);
    return await httpGet(url, queryParameters: dataQueryParameters);
  }

  //This method returns a String of server url
  @override
  String toString() {
    return '$serverUrl => $username : $password';
  }
}
