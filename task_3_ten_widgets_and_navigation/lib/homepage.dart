// ignore_for_file: unused_field, unused_import, unrelated_type_equality_checks, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:task_3_ten_widgets_and_navigation/showdata.dart';

enum gendertype { Male, Female, other }

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  _HomepageState() {
    _selectedvalue = countrylist[0];
  }
  final _formkey = GlobalKey<FormState>();
  late String name;
  late String fatherName;
  late String mobileNumber;
  late String country;
  late String email;
  late String password;
  late String gender;
  late String address;
  late String date;
  TextEditingController namecontroller = TextEditingController();
    TextEditingController addresscontroller = TextEditingController();
  TextEditingController fathernamecontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController datepick = TextEditingController();
  bool passwordVisible = false;
  gendertype? _gendervalue;
  final countrylist = [
    'Saudi Arabia',
    'England',
    'Pakistan',
    'USA',
    'Canada',
    'UAE',
    'Australia',
    'India'
  ];
  String _selectedvalue = '';
  List<String> _selectedSkills = [''];

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success!'),
          content: Text('Your form has been submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.orange.shade900,
        title: Text('Task3 BTF'),
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Colors.orange.shade300,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Submit Your Data',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: namecontroller,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp('[\/!1234567890|.,><=+:;@#%^&*()?-_\${}]'))
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person_2_outlined),
                        prefixIconColor: Colors.deepOrange,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: fathernamecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp('[\/!1234567890|.,><=+:;@#%^&*()?-_\${}]'))
                      ],
                      decoration: InputDecoration(
                        labelText: 'Father Name',
                        prefixIcon: Icon(Icons.person_2_outlined),
                        prefixIconColor: Colors.deepOrange,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: mobilenumbercontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Mobile No',
                        prefixIcon: Icon(Icons.phone_android_rounded),
                        prefixIconColor: Colors.deepOrange,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: emailcontroller,
                      validator: validatemail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_rounded),
                        prefixIconColor: Colors.deepOrange,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      obscureText: passwordVisible,
                      controller: passwordcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        if (value.contains('#') ||
                            value.contains('@') ||
                            value.contains('!') ||
                            value.contains('\$') ||
                            value.contains('^') ||
                            value.contains('&') ||
                            value.contains('*')) {
                        } else {
                          return 'Value must contain atleast one special character';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        helperText: 'Password must contains special character',
                        prefixIcon: Icon(Icons.code_off_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                        prefixIconColor: Colors.deepOrange,
                        suffixIconColor: Colors.deepOrange,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                  activeColor: Colors.deepOrange,
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text('Male'),
                                  value: gendertype.Male,
                                  groupValue: _gendervalue,
                                  dense: true,
                                  onChanged: (value) {
                                    setState(() {
                                      _gendervalue = value;
                                    });
                                  }),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  activeColor: Colors.deepOrange,
                                  title: Text('Female'),
                                  dense: true,
                                  value: gendertype.Female,
                                  groupValue: _gendervalue,
                                  onChanged: (value) {
                                    setState(() {
                                      _gendervalue = value;
                                    });
                                  }),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  activeColor: Colors.deepOrange,
                                  title: Text('other'),
                                  dense: true,
                                  value: gendertype.other,
                                  groupValue: _gendervalue,
                                  onChanged: (value) {
                                    setState(() {
                                      _gendervalue = value;
                                    });
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: addresscontroller,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp('[\/!1234567890|.,><=+:;@#%^&*()?-_\${}]'))
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        prefixIcon: Icon(Icons.person_2_outlined),
                        prefixIconColor: Colors.deepOrange,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          'Select Country',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  labelText: 'Select one',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: Colors.deepOrange))),
                              value: _selectedvalue,
                              items: countrylist.map((e) {
                                return DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedvalue = value as String;
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Skills',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: Colors.deepOrange,
                                  title: Text('C++'),
                                  value: _selectedSkills.contains('C++'),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        _selectedSkills.add('C++');
                                      } else {
                                        _selectedSkills.remove('C++');
                                      }
                                    });
                                  }),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: Colors.deepOrange,
                                  title: Text('Python'),
                                  value: _selectedSkills.contains('Python'),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        _selectedSkills.add('Python');
                                      } else {
                                        _selectedSkills.remove('Python');
                                      }
                                    });
                                  }),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: Colors.deepOrange,
                                  title: Text('Flutter'),
                                  value: _selectedSkills.contains('Flutter'),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        _selectedSkills.add('Flutter');
                                      } else {
                                        _selectedSkills.remove('Flutter');
                                      }
                                    });
                                  }),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: Colors.deepOrange,
                                  title: Text('Django'),
                                  value: _selectedSkills.contains('Django'),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        _selectedSkills.add('Django');
                                      } else {
                                        _selectedSkills.remove('Django');
                                      }
                                    });
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: datepick,
                      onTap: () {
                        _selectdate();
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of Joining',
                        prefixIcon: Icon(Icons.calendar_month_rounded),
                        prefixIconColor: Colors.deepOrange,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.orange)),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade100,
                          ),
                          onPressed: () {
                            try {
                              if (_formkey.currentState!.validate()) {
                                _showSuccessDialog(context);
                                name = namecontroller.text;
                                fatherName = fathernamecontroller.text;
                                mobileNumber = mobilenumbercontroller.text;
                                email = emailcontroller.text;
                                password = passwordcontroller.text;
                                country = _selectedvalue;
                                gender = _gendervalue!.name;
                                date = datepick.text;
                                address = addresscontroller.text;
                                print(name);
                                print(fatherName);
                                print(mobileNumber);
                                print(email);
                                print(password);
                                print(gender);
                                print(address);
                                print(country);
                                print(_selectedSkills);
                                print(date);
                              }
                            } catch (e) {
                              print('error $e');
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade100,
                          ),
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Secondscreen(name: name,fatherName: fatherName,mobileNumber: mobileNumber,email: email,gender: gender,country: country,password: password,selectedDate: date,selectedCheckboxes: _selectedSkills,address: address,)));
                          },
                          child: Text(
                            'Show Data',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  String? validatemail(String? value) {
    if (value!.isEmpty) {
      return 'This field cannot be empty';
    }
    if (EmailValidator.validate(value)) {
      // print('valid email');
    } else {
      return 'Please enter valid email';
    }
    return null;
  }

  Future<void> _selectdate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    if (picked != null) {
      DateTime datevalue = picked;
      setState(() {
        datepick.text =
            picked.toString().split(" ")[0].split("-").reversed.join("-");
      });
    }
  }
}
