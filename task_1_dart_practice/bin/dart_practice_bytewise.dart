
import 'package:dart_practice_bytewise/dart_practice_bytewise.dart' as dart_practice_bytewise;

// Bytewise fellowship program
//Muhammad Ammar Bin Saeed
//Task1- Dart BASICS
// ignore_for_file: unused_local_variable, unused_import
import 'dart:io';
class contact{
    final String name;
    final String phone_number;
    contact(this.name,this.phone_number);
}
class persons extends contact{
  persons(super.name, super.phone_number);
   printcontact(int i, contact contactss){
      print('Person ${i+1} is  ' + contactss.name);
      print('His mobile number is ' + contactss.phone_number);
    }
}


void main(){
    print('Contact management system');
    List<contact> contacts = [];
    bool again = false;
    var person;
    print(' How many contacts u want to enter: ');
    int no_of_contact = int.parse(stdin.readLineSync()!);
 while(true){
   if(again == false){
    
   
   for(int i=0; i<no_of_contact;i++){
      print('Enter name: ');
      String? name  = stdin.readLineSync();
      print('Enter Phone number: ');
      String? phone_no = stdin.readLineSync();
      contacts.add(contact(name!, phone_no!));

   }
   print('DID YOU WANT TO PRINT CONTACTS?(y for yes/ n for no) ');
   String? check = stdin.readLineSync();
   if(check == 'y'){
   for(int i=0; i<no_of_contact;i++){
       person = persons(contacts[i].name, contacts[i].phone_number);
        person.printcontact(i,contacts[i]);
   } 
   }
   else{
    print('Okay, Enjoy the Day!');
   }
   print('Did you want to terminate the program??');
   print('press y for yes or n for no ');
   String? checkagain = stdin.readLineSync();
   if(checkagain == 'y'){
    exit(0);
   }
   else{
    again = true;
   }
   
    }
    else{
      print(' How many contacts u want to enter: ');
    int againcontact = int.parse(stdin.readLineSync()!);
   
   for(int i=no_of_contact; i<(no_of_contact+againcontact);i++){
      print('Enter name: ');
      String? name  = stdin.readLineSync();
      print('Enter Phone number: ');
      String? phone_no = stdin.readLineSync();
      contacts.add(contact(name!, phone_no!));

   }
   print('DID YOU WANT TO PRINT CONTACTS?(y for yes/ n for no) ');
   String? check = stdin.readLineSync();
   if(check == 'y'){
   for(int i=0; i<(no_of_contact+againcontact);i++){
       person = persons(contacts[i].name, contacts[i].phone_number);
        person.printcontact(i,contacts[i]);
   } 
   }
   else{
    print('Okay, Enjoy the Day!');
   }
   print('Did you want to terminate the program??');
   print('press y for yes or n for no ');
   String? checkagain = stdin.readLineSync();
   if(checkagain == 'y'){
    exit(0);
   }
   else{
    again = true;
    main();
   }
    }
 }
 
}
