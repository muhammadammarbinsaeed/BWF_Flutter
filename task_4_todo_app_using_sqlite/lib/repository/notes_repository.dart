// ignore_for_file: unused_field, unused_element, unused_local_variable


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_4_todo_app_using_sqlite/model/note.dart';

class NotesRepository{
  static const _dbname = 'notes_database.db';
  static const _tablename = 'notes';
 static  Future<Database> _database() async{
         final database = openDatabase(
          join(await getDatabasesPath(),_dbname),
          onCreate: (db,version){
            return db.execute(
             'CREATE TABLE $_tablename(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, createdAt TEXT NOT NULL, Status TEXT)',
            );
          },
          version: 1,

         );
         return database;
  }

 static insert({required Note note}) async{
    final db = await _database();
    await db.insert(_tablename, 
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
  static Future<List<Note>> getNotes() async{
    final db = await _database();
    try {
    // final List<Map<String,dynamic>> maps = await db.query(_tablename);
    // return List.generate(maps.length, (i){
    //         return Note(
    //           id: maps[i]['id'] as int,
    //           title: maps[i]['title'] as String, 
    //           description: maps[i]['description'] as String, 
    //           createdAt: DateTime.parse(maps[i]['createdAt'] as String)
    //           );
    // });
    final List<Map<String, dynamic>> maps = await db.query(_tablename);
    print('Retrieved maps from database: $maps');
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }
  catch(e){
    print('ERROR IN FETCHING DATA ${e}');
    return List.empty();
  }
  }
  static updatenote({required Note note})async{
           final db = await _database();
           await db.update(_tablename
            , 
            note.toMap(),
            where: 'id = ?',
            whereArgs: [note.id]
            );
        
  }

  static deletenote({required Note note}) async{
                  final db = await _database();
                  await db.delete(
                    _tablename,
                    where: 'id = ?',
                    whereArgs: [note.id]

                  );
  }
}
