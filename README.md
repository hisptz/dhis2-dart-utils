<h3 align="center">DHIS2 DART UTILITIES </h3>

<p align="center"> A collection of data models, constants and utility functions used to build a DHIS2 app in dart.  
    <br> 
</p>

### Contents:

- [Getting Started](#getting_started)
- [Testing and Development](#test_and_develop)
- [Usage](#usage)

## Features

Available features in this util libary are:

<ul>
  <li>Generator function for DHIS2 uid.</li>
  <li>Utilities, data models and constants for DHI2 periods.</li>
  <li>DHI2 Program indicator engine.</li>
  <li>DHI2 Program rule engine.</li>
</ul>

## Getting Started <a name = "getting_started"></a>

### <li>Package Installation</li>

The package can be installed using following alternatives:

- For a dart project use the command:

```
dart pub add dhis2_dart_utils
```

- For a flutter project use the command:

```
flutter pub add dhis2_dart_utils
```

- Adding it directly on the `pubspec.yaml` dependencies and running `flutter pug get` or `dart pub get`.

```
dependencies:
  dhis2_dart_utils: <version>
```

### <li>Testing and Development</li> <a name = "test_and_develop"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

```
 git clone <github_repository_url>
```

After getting a copy of the project source code, the following command will download all the project dependencies ready for testing, running and deploying the package

```
 cd <repository_name>

 dart pub get
```

Examples can be run from the examples folder using the `dart run` commands.

Tests can be run on the project folder by the command

```
dart test
```

## Usage <a name = "usage"></a>

### <li>How to Import</li>

```
import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';
```

For more examples, [click here!](https://github.com/hisptz/dhis2-dart-utils/blob/main/example/README.md)
