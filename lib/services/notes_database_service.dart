import 'package:assignment_coding_ninja/model/notes_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabaseService {
  static Database? _db;
  static final NotesDatabaseService instance = NotesDatabaseService._constructor();

  final String tableName = "Notes";
  final String notesId = "NoteId";
  final String notesTitle = "NoteTitle";
  final String notesContent = "NoteContent";
  final String createdAt = "NoteCreatedAt";
  final String updatedAt = "NoteUpdatedAt";

  NotesDatabaseService._constructor();

  Future<Database> get database async{
    if(_db != null){
      return _db!;
    }
    else{
      _db = await getDatabase();
      return _db!;
    }
  }

  Future<Database> getDatabase() async{
    final databaseDirectoryPath = await getDatabasesPath();
    final databasePath = join(databaseDirectoryPath, "note_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $tableName(
            $notesId INTEGER PRIMARY KEY AUTOINCREMENT,
            $notesTitle TEXT NOT NULL,
            $notesContent TEXT NOT NULL,
            $createdAt INTEGER NOT NULL,
            $updatedAt INTEGER NOT NULL
          )
        ''');
      },
    );
    return database;
  }

  Future<void> insertNote(String title, String content, int createdAt) async{
    final db = await database;
    await db.insert(
      tableName,
      {
        notesTitle : title,
        notesContent : content,
        this.createdAt : createdAt,
        updatedAt : createdAt
      },
    );
  }

  Future<List<NotesClass>> getNotes() async{ 
    final db = await database;
    final data = await db.query(tableName);
    List<NotesClass> notes = data.map((e) => NotesClass(
      notesId: e["NoteId"] as int,
      notesTitle: e["NoteTitle"] as String,
      notesContent: e["NoteContent"] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(e["NoteCreatedAt"] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(e["NoteUpdatedAt"] as int),
    )).toList();
    return notes;
  }

  Future<void> updateNote(int id,String title, String content) async{ 
    final db = await database;
    await db.update(
      tableName, 
      {
        notesTitle : title,
        notesContent : content,
        updatedAt : DateTime.now().millisecondsSinceEpoch,
      },
      where: "$notesId = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteNote(int id) async{
    final db = await database;
    await db.delete(
      tableName,
      where: "$notesId = ?",
      whereArgs: [id],
    );
  }
}

