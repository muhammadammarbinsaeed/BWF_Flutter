// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unused_local_variable, unused_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:task_6_e_commerce_gharmall/providers.dart';

class ChipWidget extends ConsumerStatefulWidget {
  var chiplabel;
  var textcolor;
  var activecolor;

  ChipWidget({
    Key? key,
    required this.chiplabel,
    required this.textcolor,
    required this.activecolor,
  }) : super(key: key);

  @override
  ConsumerState<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends ConsumerState<ChipWidget> {
  
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4),
      child: Chip(
        side: BorderSide.none,
        label: Text(widget.chiplabel, style: TextStyle(color: widget.textcolor)),
        backgroundColor: ref.watch(activeChip) == widget.chiplabel
            ? Colors.grey.shade800 // Active color when clicked
            : Colors.grey.shade200, // Default color for others
      ),
    );
  }
}