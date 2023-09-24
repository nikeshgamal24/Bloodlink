import 'package:flutter/material.dart';

class ActiveDonorDetail extends StatelessWidget {
  final String bloodGroup;
  final String bloodCount;
  final Color textColor;
  const ActiveDonorDetail(
      {super.key,
      required this.bloodCount,
      required this.bloodGroup,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 160,
      decoration:const BoxDecoration(
        border: Border(
          bottom: BorderSide(
          color: Colors.black12,
          width: 1.0,
          style: BorderStyle.solid,
        ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            bloodGroup,
            style: TextStyle(
              fontSize: 22,
              color: textColor,
            ),
          ),
          Text(
            bloodCount,
            style: TextStyle(
              fontSize: 22,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }
}
