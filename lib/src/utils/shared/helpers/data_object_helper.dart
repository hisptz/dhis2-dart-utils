import '../exceptions/data_object_exception.dart';

class DataObjectHelper {
  static String getValueFromDataObject(String uid, Map dataObject) {
    // TODO Add a default value for when the uid is not in the dataObject
    var value = '0';
    try {
      dataObject.forEach((dataObjectKey, dataObjectValue) {
        if (uid.contains(dataObjectKey)) {
          value = '$dataObjectValue';
          return;
        }
      });
      return value;
    } catch (e) {
      throw DataObjectException('getValueFromDataObject $e');
    }
  }
}
