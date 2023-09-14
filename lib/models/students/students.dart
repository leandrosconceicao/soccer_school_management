import 'package:soccer_school/models/base/database.dart';

import '../base/person.dart';

class Students extends Person {

  bool isOverdue;
  String maturiryDate;

  Students({
    this.isOverdue=false,
    this.maturiryDate="",
    super.id = "",
    super.name="",
    super.birthDate,
    super.createdAt="",
    super.isActive
  });

  factory Students.fromJson(Map json, String id) {
    final instance = Students(
      isOverdue: json[_isOverdue],
      name: json[_name],
      id: id,
      birthDate: json[_birthDate],
      createdAt: json[_createdAt],
      isActive: json[_isActive],
      maturiryDate: json[_maturiryDate]
    );
    return instance;
  }


  Map<String, dynamic> toJson() {
    return {
      _name: name,
      _birthDate: birthDate,
      _createdAt: DateTime.now().toIso8601String(),
      _isActive: isActive,
      _isOverdue: isOverdue,
      _maturiryDate: maturiryDate
    };
  }

  static Future<Students?> findOne(String id) async {
    final instance = await AppDatabase.fetchOne(_path, id, parser: Students.fromJson);
    return instance;
  }

  
  Future<void> addNew() async {
    save(_path, toJson());
  }

  Future<void> manageOverDue(bool value) async {
    final collection = ref(_path).child(id);
    await collection.set({_isOverdue: value});
  }

  static String get _path => "students";
  static const _name = "name";
  static const _birthDate = "birth_date";
  static const _createdAt = "created_at";
  static const _isActive = "isActive";
  static const _isOverdue = "isOverdue";
  static const _maturiryDate = "maturiry_date";
}