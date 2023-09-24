import 'package:flutter/material.dart';

class ColorLabel extends StatelessWidget {
  final Color labelColor;
  final String? textLabel;
  const ColorLabel({super.key, required this.labelColor, required this.textLabel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            color:labelColor,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 5,),
          SizedBox(
            child: Text(
              textLabel!,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}