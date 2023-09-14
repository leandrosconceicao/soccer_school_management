import 'package:soccer_school/models/base/database.dart';

abstract class Person extends AppDatabase {
  String id;
  String name;
  String createdAt;
  String birthDate;
  bool isActive;
  
  Person({
    required this.id,
    required this.name,
    required this.createdAt,
    this.birthDate="",
    this.isActive=true
  });

  num get getAge {
    final date = getDate(birthDate);
    return DateTime.now().year - date.year;
  }
}