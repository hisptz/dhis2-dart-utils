import 'dart:convert';
import 'dart:math';
import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';

Future<void> main() async {
  // EXAMPLE: Http Service functions
  Map<String, dynamic> credentials = {
    "username": "system",
    "password": "District1#",
    "serverUrl": "https://dev.hisptz.com/dhis2/"
  };

  Map<String, dynamic> queryParameters = {};

  String url = "api/dataStore/httpTests/${Random().nextInt(77)}";

  Map<String, dynamic> body = {
    "id": Random().nextInt(77),
    "name": "Testing Http Service functions",
  };

  print(
      'Domain Host function returns a string: ${HttpService(username: credentials["username"], password: credentials["password"], serverUrl: credentials["serverUrl"]).domainHost}');

  print(
      'Domain Path function returns a string: ${HttpService(username: credentials["username"], password: credentials["password"], serverUrl: credentials["serverUrl"]).domainPath}');

  print(
      'Generate Api Url: ${HttpService(username: credentials["username"], password: credentials["password"], serverUrl: credentials["serverUrl"]).getApiUrl(url, queryParameters: queryParameters)}');

  print(
      'Send POST Request: ${await HttpService(username: credentials["username"], password: credentials["password"], serverUrl: credentials["serverUrl"]).httpPost(url, jsonEncode(body))}');

  print(
      'Send GET Request: ${await HttpService(username: credentials["username"], password: credentials["password"], serverUrl: credentials["serverUrl"]).httpGet(url)}');

  print(
      'Send DELETE Request: ${await HttpService(username: credentials["username"], password: credentials["password"], serverUrl: credentials["serverUrl"]).httpDelete(url)}');

  print(
      'Send PUT Request: ${await HttpService(username: credentials["username"], password: credentials["password"], serverUrl: credentials["serverUrl"]).httpPut(url, jsonEncode(body))}');

  print(
      'Send GET Pagination Request: ${await HttpService(username: credentials["username"], password: credentials["password"], serverUrl: credentials["serverUrl"]).httpGetPagination(url, queryParameters)}');

  print(
      'Server Url String: ${HttpService(username: credentials["username"], password: credentials["password"], serverUrl: credentials["serverUrl"]).toString()}');
}
