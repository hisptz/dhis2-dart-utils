import 'package:dart_date/dart_date.dart';

class Period {
  late String id;
  late String name;
  late DateTime? start;
  late DateTime? end;
  late String type;
  late String category;

  Period.fromObject(Map<String, dynamic> object,
      {required this.type, required this.category}) {
    id = object['id'];
    name = object['name'];
    start = null;
    end = null;
  }

  Period.fromInterval(Interval interval,
      {required Function idGenerator,
      required Function nameGenerator,
      required this.type,
      required this.category}) {
    start = interval.start;
    end = interval.end;
    id = idGenerator(interval);
    name = nameGenerator(interval);
  }

  @override
  String toString() {
    return "$id $name ${start != null ? "(${start?.toHumanString() ?? ''} - ${end?.toHumanString() ?? ''})" : ""}";
  }
}
