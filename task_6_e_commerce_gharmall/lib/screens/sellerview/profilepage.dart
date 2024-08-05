// ignore_for_file: unused_import, use_key_in_widget_constructors, must_be_immutable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';
import 'package:task_6_e_commerce_gharmall/screens/user.dart';

// Service for handling user updates
// final userUpdateProvider = Provider((ref) => UserUpdateService(ref as WidgetRef));

// class UserUpdateService {
//   final WidgetRef ref;

//   UserUpdateService(this.ref);

//   Future<void> updateUser(user user) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update(user.toMap());
//       ref.invalidate(fetchuserdata);
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Profile updated')));
//     } catch (e) {
//       // Handle update error
//       print('Error updating user: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error updating profile')));
//     }
//   }
// }

class Profilepage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      // body: userAsyncValue.when(
      //   data: (users) => ProfileForm(user: users),
      //   loading: () => Center(child: CircularProgressIndicator()),
      //   error: (e, stack) => Center(child: Text('Error: $e')),
      // ),
    );
  }
}

// class ProfileForm extends ConsumerWidget {
//   final User? user;

//   const ProfileForm({super.key, this.user});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userState = ref.watch(userStateProvider);

//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           if (user != null) ...[
//             TextFormField(
//               initialValue: user.email,
//               decoration: InputDecoration(labelText: 'Email'),
//               onChanged: (value) =>
//                   ref.read(userUpdateProvider).updateUser(userState!.copyWith(email: value)),
//             ),
//             // ... other TextFormField widgets
//           ],
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () async {
//               // No need for Future.delayed here, update happens immediately
//               // upon button press
//               if (userState != null) {
//                 await ref.read(userUpdateProvider).updateUser(userState);
//               }
//             },
//             child: Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }
// }
