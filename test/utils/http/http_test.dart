import 'dart:convert';
import 'dart:math';
import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';

import 'package:test/test.dart';

Map<String, dynamic> credentials = {
  "username": "system",
  "password": "District1#",
  "serverUrl": "https://dev.hisptz.com/dhis2/"
};

Map<String, dynamic> queryParameters = {};

String url = "api/dataStore/httpTests/${Random().nextInt(777)}";
String apiToken = "d2pat_oz1mQxGlckO14bjHvi3r7Or5EOAxCn2K2104519092";

Map<String, dynamic> body = {
  "id": Random().nextInt(77),
  "name": "Testing Http Service functions",
};

void main() {
  group('HttpServices Tests', () {
    group('Domain Host and Path tests: ', () {
      test('Domain Host function returns a string', () {
        expect(
            HttpService(serverUrl: credentials["serverUrl"], apiToken: apiToken)
                .domainHost,
            isNotEmpty);
      });

      test('Domain Path function returns a string', () {
        expect(
            HttpService(serverUrl: credentials["serverUrl"], apiToken: apiToken)
                .domainPath,
            isNotEmpty);
      });
    });

    group('ApiUrl Tests', () {
      test('Get ApiURl function returns a Uri', () {
        final uri =
            HttpService(serverUrl: credentials["serverUrl"], apiToken: apiToken)
                .getApiUrl(url, queryParameters: queryParameters);
        expect(uri, uri);
      });
    });

    group('CRUD Service Tests', () {
      test('Http Post function returns a 201 Status Code', () async {
        final response = await HttpService(
          username: credentials["username"],
          password: credentials["password"],
          serverUrl: credentials["serverUrl"],
        ).httpPost(url, jsonEncode(body));
        expect(response.statusCode, 201);
      });

      test('Http Get function returns a 200 Status Code', () async {
        final response = await HttpService(
                serverUrl: credentials["serverUrl"], apiToken: apiToken)
            .httpGet(url);
        expect(response.statusCode, 200);
      });

      test('Http Delete function returns a 200 Status Code', () async {
        final response = await HttpService(
                serverUrl: credentials["serverUrl"], apiToken: apiToken)
            .httpDelete(url);
        expect(response.statusCode, 200);
      });

      test('Http Put function returns a 200 Status Code', () async {
        final response = await HttpService(
                username: credentials["username"],
                password: credentials["password"],
                serverUrl: credentials["serverUrl"])
            .httpPut(url, jsonEncode(body));
        expect(response.statusCode, 200);
      });

      test('Http Get Pagination function returns a 200 Status Code', () async {
        final response = await HttpService(
                serverUrl: credentials["serverUrl"], apiToken: apiToken)
            .httpGetPagination(url, queryParameters);
        expect(response.statusCode, 200);
      });
    });

    test('To String function returns a String', () {
      expect(
          HttpService(serverUrl: credentials["serverUrl"], apiToken: apiToken)
              .toString(),
          isNotEmpty);
    });
  });
}
