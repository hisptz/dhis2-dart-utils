class DataObjectHelper {
  static String getValueFromDataObject(String uid, Map dataObject) {
    // TODO Add a default value for when the uid is not in the dataObject
    var value = '0';
    dataObject.forEach((dataObjectKey, dataObjectValue) {
      if (uid.contains(dataObjectKey)) {
        value = '$dataObjectValue';
        return;
      }
    });
    return value;
  }
}
