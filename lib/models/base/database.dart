import 'package:firebase_database/firebase_database.dart';
import 'package:soccer_school/utils/utils.dart';
import 'package:uuid/uuid.dart';

class AppDatabase extends Uuid with DateFormatters {
  static final _database = FirebaseDatabase.instance;

  DatabaseReference ref(String path) {
    return _database.ref(path);
  }

  String getId() {
    return v4();
  }

  Future<void> save(String path, Map<String, dynamic> data) async {
    // final parseCode = getId();
    final collection = ref(path);
    await collection.push().set(data);
  }

  Future<void> update(
      String path, String code, Map<String, Object?> data) async {
    final collection = ref("$path/$code");
    await collection.update(data);
  }

  static Future<T?> fetchOne<T>(
    String path,
    String id, {
    required T Function(Map, String) parser,
  }) async {
    final collection = AppDatabase().ref(path);
    final data = await collection.child(id).get();
    if (!data.exists) {
      return null;
    }
    final value = data.value as Map;
    final instance = parser(value, id);
    return instance;
  }

  static Future<List<T?>> fetchAll<T>(String path, {required T Function(Map, String) parser}) async {
    final ref = AppDatabase().ref(path);
    final data = await ref.get();
    if (!data.exists) {
      return [];
    }
    final values = <T>[];
    (data.value as Map?)?.forEach((key, value) {
      values.add(parser(value, key));
    });
    return values;
  }
}
