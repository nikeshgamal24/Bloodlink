import 'package:flutter/material.dart';
import 'package:test/features/auth/profile/screens/profile_screen.dart';

class ProfileIcon extends StatefulWidget {
  const ProfileIcon({super.key});

  @override
  State<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProfileScreen.routeName);
      },
      child: Container(
        // color: Colors.transparent,
        // height: 42,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: const Icon(
          Icons.account_circle_outlined,
          color: Colors.black,
          size: 32,
        ),
      ),
    );
  }
}
