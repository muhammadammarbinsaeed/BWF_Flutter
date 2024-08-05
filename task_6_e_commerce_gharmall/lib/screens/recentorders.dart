// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_6_e_commerce_gharmall/providers.dart';

class recentorders extends ConsumerStatefulWidget {
  const recentorders({super.key});

  @override
  ConsumerState<recentorders> createState() => _recentordersState();
}

class _recentordersState extends  ConsumerState<recentorders> {
  @override
  Widget build(BuildContext context) {
     final recentorders = ref.watch(fetchrecentorders);
    return Scaffold(
      body: recentorders.when(data: (Data){
       if(Data!=null){
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      itemCount: Data.length,
                      itemBuilder: (context,index){
                       return Text('');
                      }
                    ),
                    ),
                  );
       } 


        return null;
      

      }, error: (e, st) => Center(child: Text('Error: ${e.toString()}')), 
      loading: () => Center(child: CircularProgressIndicator())
      ),
    );
  }
}