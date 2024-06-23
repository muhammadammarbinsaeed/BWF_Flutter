// ignore_for_file: prefer_const_constructors, must_be_immutable, unused_import


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_4_todo_app_using_sqlite/model/note.dart';
import 'package:task_4_todo_app_using_sqlite/screens/addnote/addnote.dart';
class ItemNote extends StatelessWidget {
  ItemNote({super.key, required this.note}
  ){
    color = _getColorForNote();
  }
  
 
   List colors = [
  Colors.orange.shade100,
  Colors.blue.shade100,
  Colors.red.shade100,
  Colors.purple.shade100,
  Colors.brown.shade100,
  Colors.green.shade100,
  Colors.pink.shade100,
  Colors.teal.shade100,
  Colors.yellow.shade100,
  Colors.grey.shade100,
  Colors.cyan.shade100,
  Colors.lime.shade100,
  Colors.indigo.shade100,
  Colors.amber.shade100,
  Colors.deepOrange.shade100,
  Colors.lightBlue.shade100,
  Colors.deepPurple.shade100,
  Colors.lightGreen.shade100,
  Colors.blueGrey.shade100,
  Colors.orangeAccent.shade100,
  Colors.blueAccent.shade100,
  Colors.redAccent.shade100,
  Colors.purpleAccent.shade100,
  Colors.greenAccent.shade100,
  Colors.pinkAccent.shade100
];

  final Note note;
  late final Color color;
  Color _getColorForNote() {
    // Generate a unique color based on the note's properties
    int index = note.title.hashCode % colors.length;
    return colors[index];
  }
    Color _darkenColor(Color color, [double amount = 0.3]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>addnotescreen(notee: note,)));
      },
      child: Card(
        elevation: 0.8,
        // color: Colors.orange.shade100,
        color: color,
        
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: const Color.fromARGB(255, 150, 90, 0)
                  color: _darkenColor(color)
                ),
                child: Column(
                  children: [
                    Text(DateFormat(DateFormat.ABBR_MONTH).format(note.createdAt), style: TextStyle(color: Colors.white70),),
                    SizedBox(height: 3,),
                    Text(DateFormat(DateFormat.DAY).format(note.createdAt), style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                    SizedBox(height: 3,),
                    Text(note.createdAt.year.toString(),style: TextStyle(color: Colors.white70),)
                  ],
                ),
        
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(note.title,style: note.Status=='Pending'?Theme.of(context).textTheme.titleMedium:TextStyle(decoration: TextDecoration.lineThrough),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(DateFormat(DateFormat.HOUR_MINUTE).format(note.createdAt), style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                    Text(note.description,
                    style: 
                    note.Status=='Pending'?
                     TextStyle(
                      fontWeight: FontWeight.w300,
                      height: 1.5
                    ):TextStyle(
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                      decoration: TextDecoration.lineThrough
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
        
                    ),
        
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}