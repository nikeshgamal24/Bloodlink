import 'package:flutter/material.dart';
import 'package:test/constants/global_variables.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.onTap, required this.hintText});
  final String hintText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        backgroundColor: GlobalVariables.loginSignUpButtonBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        hintText,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
