import 'package:flutter/material.dart';
import 'package:test/constants/global_variables.dart';

class DailyUpdateContainer extends StatelessWidget {
  final String updateDate;
  final String titleOfContainer;
  const DailyUpdateContainer(
      {super.key, required this.updateDate, required this.titleOfContainer});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 148,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(1.0, 1.0),
              spreadRadius: 1.0,
              blurRadius: 5,
            ),
            const BoxShadow(
              color: Color.fromARGB(255, 247, 245, 245),
              offset: Offset(-1.0, -1.0),
              spreadRadius: 1.0,
              blurRadius: 5,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
             Text(
              titleOfContainer,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: GlobalVariables.titleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                updateDate,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  color: GlobalVariables.dataDisplayColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
