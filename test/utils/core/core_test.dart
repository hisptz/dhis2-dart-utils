import 'package:dhis2_dart_utils/dhis2_dart_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Core Utils Tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    group('UID generator tests', () {
      test('GetUid function returns a string', () {
        expect(Core.getUid(), isNotEmpty);
      });

      test('Returned UID from GetUid function has length of 11', () {
        expect(Core.getUid(), hasLength(11));
      });
    });
  });
}
