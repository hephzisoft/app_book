import 'package:flutter/material.dart';

import '../config/colors.dart';

class TextFormDesign extends StatelessWidget {
  const TextFormDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 300,
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(color: whiteSoft, width: 2),
        borderRadius: BorderRadius.circular(20),
        color: whiteSoft,
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, top: 15),
          hintText: 'hintText',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
