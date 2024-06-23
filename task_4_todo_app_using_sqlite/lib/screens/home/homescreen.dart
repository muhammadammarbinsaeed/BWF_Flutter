
// ignore_for_file: dead_code, override_on_non_overriding_member


import 'package:flutter/material.dart';
import 'package:task_4_todo_app_using_sqlite/model/note.dart';
import 'package:task_4_todo_app_using_sqlite/repository/notes_repository.dart';
import 'package:task_4_todo_app_using_sqlite/screens/addnote/addnote.dart';
import 'package:task_4_todo_app_using_sqlite/screens/widgets/item_note.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<Note>> _notesFuture;
  // late final Note note;
  // late Future<List<Note>> _updatedFuture;
 
 @override
  void initState() {
    super.initState();
    // _notesFuture = NotesRepository.getNotes();
    _refreshNotes();
    
  }
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshNotes(); // Ensure the notes are refreshed when dependencies change
  }
  Future<void> _refreshNotes() async {
    setState(() {
      _notesFuture = NotesRepository.getNotes();
    });
  }
    Future<void> _deletenote(Note note) async {
       try {
        NotesRepository.deletenote(note: note);
        _refreshNotes();
       } catch (e) {
         print('failed to delete note');
       }
     
  
  }
  
  // void _loadNotes() {
  //   _notesFuture = NotesRepository.getNotes();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
               appBar: AppBar(
                backgroundColor: Colors.orange,
                automaticallyImplyLeading: false
                ,
                elevation: 1.0,
                  title: Text('Todo App'),
                  centerTitle: true,
               ),

        body:FutureBuilder(
          future: _notesFuture, 
          
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
            if(snapshot.connectionState == ConnectionState.done){
              // _refreshNotes();
              if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
               else if(snapshot.data == null || snapshot.data!.isEmpty){
                  return const Center(child: Text('Empty'),);
               }
               return ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  // ignore: unused_local_variable
                  for( var note in snapshot.data!)
                   Dismissible(
                    key: ValueKey(note.id),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _deletenote(note);
                    },
                    child: ItemNote(note: note)
                    ),
                   
                ],
                
               );
            }
            return const SizedBox();
          }
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()async{
        await  Navigator.push(context, MaterialPageRoute(builder: (context)=>addnotescreen()));
           _refreshNotes();
          }
          ,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          child: Icon(Icons.add),
          ),

    );
  }
}
