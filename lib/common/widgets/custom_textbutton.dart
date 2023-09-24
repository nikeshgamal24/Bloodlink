import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget{
  final void Function()? onTap;
  final String buttonText;

  const CustomTextButton({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context){
    return TextButton(
        onPressed: onTap, 
        child:  Text(
          buttonText,
          style:const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color:Color.fromARGB(255, 53, 53, 53),
          ),)
        );
  }
}