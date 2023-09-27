import 'package:flutter/material.dart';

class UserDetailItem extends StatelessWidget {
  final String label;
  final String value;
  const UserDetailItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top:3.0,bottom:3,right: 10,left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(
                "$label: ",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 5,),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
