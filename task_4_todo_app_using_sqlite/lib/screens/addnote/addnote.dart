
import 'package:flutter/material.dart';
import 'package:task_4_todo_app_using_sqlite/model/note.dart';
import 'package:task_4_todo_app_using_sqlite/repository/notes_repository.dart';
import 'package:task_4_todo_app_using_sqlite/screens/home/homescreen.dart';

class addnotescreen extends StatefulWidget {
  final Note? notee;
  const addnotescreen({super.key,this.notee});

  @override
  State<addnotescreen> createState() => _addnotescreenState();
}

class _addnotescreenState extends State<addnotescreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();
   var status = 'Pending';
  @override
  void initState() {
    if(widget.notee != null ){
      _title.text = widget.notee!.title;
      _description.text = widget.notee!.description;
      status = widget.notee!.Status;
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 1.0,
        centerTitle: true,
        title: Text('Add Task'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
             IconButton(onPressed:
             widget.notee==null ? _insertnote: _updatenote
            , icon: Icon(Icons.save)),

          )
        ],
        // backgroundColor: ,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(13))
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: TextField(
                controller: _description,
                decoration: InputDecoration(
                  hintText: 'Start typing here..',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                  
                ),
                maxLines: 10,
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                                  labelText: 'Status',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          color: Colors.black))),
                value: status,
              items: <String>['Pending','Completed'].map((e){
                    return DropdownMenuItem(child: Text(e),
                    value: e,);
              }).toList(), 
              onChanged: (value){
                setState(() {
                  status = value!;
                });
              }),
            )
          ],
        ),
      ),
    );
  }
   _insertnote() async{
    final note = Note(
      createdAt: DateTime.now(),
      title: _title.text,
      description:  _description.text,
       Status: status ,
      );
      try {
    await NotesRepository.insert(note: note);
     Navigator.pop(context); 
    print('Note inserted successfully: ${note.title}');
     print(' ${note.description}');
      print(' ${note.createdAt}');
  } catch (e) {
    print('Failed to insert note: $e');
  }
  }
  _updatenote() async{
    final note = Note(
      id: widget.notee!.id,
      createdAt: DateTime.now(),
      title: _title.text,
      description:  _description.text, 
      Status: status ,

      );
      try {
    await NotesRepository.updatenote(note: note);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homescreen()));
    print('Note updated successfully: ${note.title}');
     print(' ${note.description}');
      print(' ${note.createdAt}');
      print('${note.Status}');
  } catch (e) {
    print('Failed to update note: $e');
  }
  }
}