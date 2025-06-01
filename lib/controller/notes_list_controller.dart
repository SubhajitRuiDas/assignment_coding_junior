import 'package:assignment_coding_ninja/model/notes_class.dart';
import 'package:assignment_coding_ninja/services/notes_database_service.dart';
import 'package:get/get.dart';

class NotesListController extends GetxController{
  var notesList = <NotesClass>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }
  
  void fetchNotes() async{
    var fetchedNotesList = await NotesDatabaseService.instance.getNotes();
    notesList.value = fetchedNotesList;
  }
  void deleteNote(int noteId) async{
    await NotesDatabaseService.instance.deleteNote(noteId);
    fetchNotes();
  }
}