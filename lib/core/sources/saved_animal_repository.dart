import 'package:pocketgue/core/core.dart';
import 'package:sqflite/sqflite.dart';

class SavedAnimalRepository {
  static const tableName = "saved_animal";
  static const columnName = "name";
  static const columnUrl = "url";
  static const columnColor = "color";
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    db = await openDatabase("${databasesPath}demo.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableName ( 
        $columnUrl text primary key, 
        $columnName text not null,
        $columnColor text not null)
      ''');
    });
  }

  Future<AnimalData> insert(AnimalData animal) async {
    await db.insert(tableName, {
      columnUrl: animal.url,
      columnName: animal.name,
      columnColor: animal.color.value.toString()
    });
    return animal;
  }

  Future<List<AnimalData>> getAnimals() async {
    List<Map<String, dynamic>> maps = await db.query(tableName,
        columns: [columnUrl, columnName, columnColor],
    );

    List<AnimalData> animals = [];
    for(final map in maps){
      animals.add(AnimalData.fromJson(map));
    }
    return animals;
  }

  Future<int> delete(String url) async {
    return await db.delete(tableName, where: '$columnUrl = ?', whereArgs: [url]);
  }

  Future close() async => db.close();
}
