import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

mixin DateFormatters {
  final _format = DateFormat("dd/MM/yyyy");
  
  DateTime getDate(String date) {
    return _format.parse(date);
  }

  // String formatDate(String date) {
  //   return format.format(date);
  // }
}

mixin idGeneration {
  final _instance = Uuid();


  String getId() {
    return _instance.v4();
  }
}