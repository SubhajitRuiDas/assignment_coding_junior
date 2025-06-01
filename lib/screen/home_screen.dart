import 'package:assignment_coding_ninja/controller/notes_list_controller.dart';
import 'package:assignment_coding_ninja/screen/notes_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final notesListController = Get.put(NotesListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes Screen"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(NotesFormScreen(appBarTxt: "Add Note",));
        },
        backgroundColor: Colors.blue[200],
        child: Icon(Icons.note_add),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        scrollDirection: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.white,),
                const SizedBox(width: 8,),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search Note",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      border: InputBorder.none,
                    ),
                  ), 
                ),
              ],
            ),
          ),
          Expanded(
            child: GetX<NotesListController>(
              builder: (controller){
                return ListView.builder(
                  itemCount: controller.notesList.length,
                  itemBuilder: (context, index) {
                    final note = controller.notesList[index];
                    return Dismissible(
                      key: Key(note.notesId.toString()),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        notesListController.deleteNote(note.notesId);
                      },
                      child: ListTile(
                        leading: CircleAvatar(radius: 10, child: Icon(Icons.note),),
                        title: Text(note.notesTitle),
                        subtitle: Text(note.notesContent),
                        contentPadding: EdgeInsets.all(15),
                        trailing: TextButton(
                          onPressed: () {
                            Get.to(NotesFormScreen(appBarTxt: "Update Note", updateNote: note,));
                          }, 
                          child: Text("Update"),
                        ),
                      ),
                    );
                  });
              }
            ),
          ),
        ],
      ),
    );
  }
}