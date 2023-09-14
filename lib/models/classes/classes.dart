import 'package:soccer_school/models/base/database.dart';
import 'package:soccer_school/models/students/students.dart';

class Classes extends AppDatabase {
  static String get _path => "classes";
  static const _desc = "description";
  static const _createdAt = "created_at";
  static const _studentIds = "student_ids";

  String description;
  String id;
  String createdAt;
  List<String>? studentIds;
  Classes({
    this.description = "",
    this.id = "",
    this.createdAt = "",
    this.studentIds,
  });

  factory Classes.fromJson(Map json, String id) {
    final instance = Classes(
        description: json[_desc],
        createdAt: json[_createdAt],
        id: id,
        studentIds: json[_studentIds]);
    return instance;
  }

  Map<String, dynamic> toJson() {
    return {
      _desc: description,
      _createdAt: DateTime.now().toIso8601String(),
    };
  }

  Future<List<Students?>> getStudentData() async {
    final data = <Students?>[];
    for (var id in studentIds ?? []) {
      final value = await Students.findOne(id);
      data.add(value);
    }
    return data;
  }

  static Future<List<Classes?>> fetchAll() async {
    return AppDatabase.fetchAll(_path, parser: Classes.fromJson);
  }

  static Future<Classes?> findOne(String id) async {
    return AppDatabase.fetchOne(_path, id, parser: Classes.fromJson);
  }

  Future<void> addNew() async {
    save(_path, toJson());
  }

  static Future<void> addNewStudent(String studentId, String classId) async {
    final ref = AppDatabase().ref(_path).child(classId).child("students");
    await ref.push().set(studentId);
  }
}
