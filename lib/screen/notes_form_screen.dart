import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesFormScreen extends StatelessWidget {
  final String appBarTxt;
  const NotesFormScreen({super.key, required this.appBarTxt});

  @override
  Widget build(BuildContext context) {
    final TextEditingController noteTitle = TextEditingController();
    final TextEditingController noteContent = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTxt),
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
              onPressed: (){Get.back();}, 
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