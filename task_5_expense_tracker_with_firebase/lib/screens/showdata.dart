import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowData extends StatefulWidget {
   const ShowData({Key? key}) : super(key: key);
    
  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: currentUser == null
          ? Center(child: Text('User not logged in'))
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Data')
                  .where('userID', isEqualTo: currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something Went Wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildPlaceholderContent(size, []);
                }
                if (snapshot.data!.docs.isEmpty) {
                  return _buildPlaceholderContent(size, []);
                }
                if (snapshot.hasData) {
                  int expenses = 0;
                  int income = 0;
        
                  for (var doc in snapshot.data!.docs) {
                    if (doc['amounttype'] == 'Expense') {
                      expenses += int.parse(doc['amount'].toString());
                    } else if (doc['amounttype'] == 'Income') {
                      income += int.parse(doc['amount'].toString());
                    }
                  }
                 
                  int total = income - expenses;
                  return _buildContent(size, snapshot.data!.docs, income, expenses, total);
                  
                }
                return Container();
              },
            ),
    );
  }

  Widget _buildPlaceholderContent(Size size, List<QueryDocumentSnapshot<Object?>> docs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardWidget(size, 'Hello', '', 0, 0, 0, docs),
        _buildTransactionsList(size, docs),
      ],
    );
  }

  Widget _buildContent(Size size, List<QueryDocumentSnapshot> docs, int income, int expenses, int total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardWidget(size, 'Hello', '', income, expenses, total, docs),
        _buildTransactionsList(size, docs),
      ],
    );
  }

  Widget _buildCardWidget(Size size, String greeting, String username, int income, int expenses, int total, List<QueryDocumentSnapshot> docs) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                FutureBuilder<String?>(
                  future: fetchUsername(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('');
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text('${snapshot.data}', style: TextStyle(fontSize: 17, color: Colors.white),);
                    } else {
                      return Text('');
                    }
                  },
                ),
                Spacer(),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '$total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Income',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreenAccent,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '$income',
                          style: TextStyle(
                            color: Colors.lightGreenAccent,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Expenses',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '$expenses',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList(Size size, List<QueryDocumentSnapshot> docs) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 17, right: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_downward),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Container(
            height: size.height * 0.35,
            child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                var doc = docs[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      await FirebaseFirestore.instance.collection("Data")
                                   .doc(doc.id).delete();
                                   
                    },
                  child: Card(
                    elevation: 1,
                    shadowColor: Colors.grey,
                    child: ListTile(
                      leading: Text(doc['date'].toString()),
                      title: Text(doc['categorytype'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(doc['amount'].toString()),
                          Icon(
                            doc['amounttype'] == 'Expense'
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: doc['amounttype'] == 'Expense'
                                ? Colors.red
                                : Colors.green,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<String> fetchUsername() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("No user is currently signed in.");
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('firstname')) {
          return data['firstname'].toString();
        } else {
          throw Exception("User document does not exist or does not contain 'firstname'.");
        }
      } else {
        throw Exception("User document does not exist.");
      }
    } catch (e) {
      print("Error fetching username: $e");
      return 'Error fetching username';
    }
  }
}

