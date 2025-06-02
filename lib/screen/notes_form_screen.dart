import 'package:assignment_coding_ninja/controller/notes_list_controller.dart';
import 'package:assignment_coding_ninja/model/notes_class.dart';
import 'package:assignment_coding_ninja/services/notes_database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesFormScreen extends StatefulWidget {
  final String appBarTxt;
  final NotesClass? updateNote;
  const NotesFormScreen({super.key, required this.appBarTxt, this.updateNote});

  @override
  State<NotesFormScreen> createState() => _NotesFormScreenState();
}

class _NotesFormScreenState extends State<NotesFormScreen> {
  late TextEditingController noteTitle;
  late TextEditingController noteContent;

  @override
  void initState() {
    super.initState();
    noteTitle = TextEditingController(text: widget.updateNote?.notesTitle ?? '');
    noteContent = TextEditingController(text: widget.updateNote?.notesContent ?? '');
  }

  @override
  void dispose() {
    noteTitle.dispose();
    noteContent.dispose();
    super.dispose();
  }

  void submitNote() async{
    if(noteTitle.text.isEmpty || noteContent.text.isEmpty){
      Get.snackbar(
        "Missing Fields",
        "Please fill both title and content fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      if(widget.updateNote == null){
        await NotesDatabaseService.instance.insertNote(noteTitle.text, noteContent.text, DateTime.now().millisecondsSinceEpoch);
      } else {
        await NotesDatabaseService.instance.updateNote(widget.updateNote!.notesId, noteTitle.text, noteContent.text);
      }

      final noteController = Get.find<NotesListController>();
      noteController.fetchNotes();
    
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong while submitting note",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTxt),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              controller: noteTitle,
              decoration: InputDecoration(
                hintText: "Enter note's title",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(style: BorderStyle.solid),
                ),
                filled: true,
                fillColor: Colors.blue[200],
              ),
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: noteContent,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "Enter note's content",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(style: BorderStyle.solid),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: submitNote, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[200],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              child: Text("Submit", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}