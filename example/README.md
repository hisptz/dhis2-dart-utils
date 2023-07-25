<h3 align="center">DHIS2 DART UTILITIES EXAMPLES</h3>
 
 <p>Helpers and classes from the DHIS2 utilities can be accessible from the </p>

### Contents:

- [UID generator](#uid)
- [Program Indicator](#programIndicator)
- [Program Rule](#programRule)
- [Http Services](#httpServices)
- [Indicator](#indicator)
- [Validation Rules](#validation)

## UID generator <a name = "uid"></a>

```
import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';

void main() {
    // uid variable holds the generated uid
    String uid = Core.getUid();
}
```

## Program Indicator <a name = "programIndicator"></a>

```
import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';

void main() {
    // Form data object
    Map programIndicatorEngineDataObject = {
        "vV9UWAZohSf": 12,
        "qrur9Dvnyt5": 30,
        "GieVkTxp4HH": 0.4,
    };

    // program indicators
    List<ProgramIndicator> programIndicators = [
        {
        "id": "yFTplrY7NaL",
        "aggregationType": "CUSTOM",
        "expression":
            "(#{Zj7UnCAulEk.vV9UWAZohSf} * #{Zj7UnCAulEk.GieVkTxp4HH}) + (#{Zj7UnCAulEk.qrur9Dvnyt5})",
        "program": "eBAyeGv0exc"
        }
    ].map((indicator) => ProgramIndicator.fromMap(indicator)).toList();

    // program indicator engine results
    Map engineResults = ProgramIndicatorEngine.evaluateProgramIndicators(
      programIndicators: programIndicators,
      dataObject: programIndicatorEngineDataObject,
    )

}
```

## Program Rule <a name = "programRule"></a>

```
import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';

void main() {
    // Program rules
    List<ProgramRule> programRules = [
        {
        "id": "fd3wL1quxGb",
        "condition": "#{gender} == 'Male'",
        "program": "eBAyeGv0exc",
        "programRuleActions": [
            {
            "id": "IrmpncBsypT",
            "programRuleActionType": "HIDEFIELD",
            "programRule": "fd3wL1quxGb",
            "dataElement": "SWfdB5lX0fk",
            "programStageSection": "d7ZILSbPgYh"
            }
        ]
        },
        {
        "id": "xZe5qCzRS0Y",
        "condition": "#{gender} == 'Male'",
        "program": "lxAQ7Zs9VYR",
        "programRuleActions": [
            {
            "id": "hwgyO59SSxu",
            "programRuleActionType": "ASSIGN",
            "programRule": "xOe5qCzRS0Y",
            "dataElement": "sWoqcoByYmD",
            "data": "false"
            }
        ]
        },
        {
        "id": "xOe5qCzRS0Y",
        "condition": "!#{womanSmoking}",
        "program": "lxAQ7Zs9VYR",
        "programRuleActions": [
            {
            "id": "hwgyO59SSxu",
            "programRuleActionType": "HIDEFIELD",
            "programRule": "xOe5qCzRS0Y",
            "dataElement": "sWoqcoByYmD",
            "data": "false"
            }
        ]
        }
    ]
        .map((Map<String, dynamic> programRule) =>
            ProgramRule.fromMap(programRule))
        .toList();

    // Program rule variables
    List<ProgramRuleVariable> programRuleVariables = [
    {
        "name": "gender",
        "id": "zINGRka3g9N",
        "programRuleVariableSourceType": "DATAELEMENT_NEWEST_EVENT_PROGRAM",
        "program": "eBAyeGv0exc",
        "dataElement": "oZg33kd9taw"
    },
    {
        "name": "womanSmoking",
        "id": "Z92dJO9gIje",
        "programRuleVariableSourceType": "DATAELEMENT_NEWEST_EVENT_PROGRAM",
        "program": "lxAQ7Zs9VYR",
        "dataElement": "sWoqcoByYmD"
    }
    ]
        .map((Map<String, dynamic> programRuleVariable) =>
            ProgramRuleVariable.fromMap(programRuleVariable))
        .toList();

    // Form data object
    Map programRuleEngineDataObject = {
    "oZg33kd9taw": "Male",
    };

  Map engineResult = ProgramRuleEngine.evaluateProgramRule(
      programRules: programRules,
      programRuleVariables: programRuleVariables,
      dataObject: programRuleEngineDataObject,
    )
}
```

## Http Services <a name = "httpServices"></a>

```
import 'dart:convert';
import 'dart:math';
import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';

void main() {
    // Credentials
    Map<String, dynamic> credentials = {
    "username": "system",
    "password": "District1#",
    "serverUrl": "https://dev.hisptz.com/dhis2/"
  };
    //Query Parameters
  Map<String, dynamic> queryParameters = {};

//Api Endpoint
  String url = "api/dataStore/httpTests/${Random().nextInt(77)}";

//Api Token
   String apiToken = "d2pat_oz1mQxGlckO14bjHvi3r7Or5EOAxCn2K2104519092";

//Body
  Map<String, dynamic> body = {
    "id": Random().nextInt(77),
    "name": "Testing Http Service functions",
  };

    String domainHost = HttpService(

                    serverUrl: credentials["serverUrl",
                    apiToken: apiToken])
                .domainHost,

    String domainPath = HttpService(

                    serverUrl: credentials["serverUrl",
                    apiToken: apiToken])
                .domainPath,

    final uri = HttpService(

                serverUrl: credentials["serverUrl",
                apiToken: apiToken])
            .getApiUrl(url, queryParameters: queryParameters);

    //POST Request
     final response = await HttpService(

                serverUrl: credentials["serverUrl",
                apiToken: apiToken])
            .httpPost(url, jsonEncode(body));

    //GET Request
      final response = await HttpService(

                serverUrl: credentials["serverUrl",
                apiToken: apiToken])
            .httpGet(url);

   //DELETE Request
      final response = await HttpService(

                serverUrl: credentials["serverUrl",
                apiToken: apiToken])
            .httpDelete(url);

    //PUT Request
    final response = await HttpService(

                serverUrl: credentials["serverUrl",
                apiToken: apiToken])
            .httpPut(url, jsonEncode(body));

    //GET Pagination Request
      final response = await HttpService(

                serverUrl: credentials["serverUrl",
                apiToken: apiToken])
            .httpGetPagination(url, queryParameters);

    String serverUrl =  HttpService(
                  serverUrl: credentials["serverUrl",
                  apiToken: apiToken])
              .toString();
}
```

## Indicator <a name = "indicator"></a>

### Coming soon!

🚧 👨🏾‍💻

## Validation Rules <a name = "validations"></a>

### Coming soon!

🚧 👨🏾‍💻
