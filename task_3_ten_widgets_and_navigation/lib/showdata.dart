import 'package:flutter/material.dart';

class Secondscreen extends StatelessWidget {
  final String name;
  final String fatherName;
  final String mobileNumber;
  final String email;
  final String gender;
   final String address;
  final String country;
  final String password;
  final String selectedDate; // Add field for selected date
  final List<String>? selectedCheckboxes; // Add field for selected checkboxes

  const Secondscreen({
    super.key,
    required this.name,
    required this.fatherName,
    required this.mobileNumber,
    required this.email,
    required this.gender,
    required this.country,
    required this.password,
    required this.selectedDate,
    this.selectedCheckboxes, required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.orange.shade900,
        title: Text('Data'),
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Colors.orange.shade300,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Card(
          elevation: 1.0,
          borderOnForeground: true,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.blue,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 220, 209),
                borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Name: $name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                        
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Father Name: $fatherName',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Mobile: $mobileNumber',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Email: $email',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Password: $password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Gender: $gender',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Address: $address',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Country: $country',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Skills: $selectedCheckboxes',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Date: $selectedDate',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
