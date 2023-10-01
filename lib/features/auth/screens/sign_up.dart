import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:test/common/widgets/custom_textfield.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/constants/utils.dart';
import 'package:test/features/auth/services/auth_service.dart';

class MySignUp extends StatefulWidget {
  static const String routeName = '/signup';
  const MySignUp({super.key});

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
//for AuthService instance
  final AuthService authService = AuthService();

  //controller for the textfield
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
      final TextEditingController _lastDonatedController =
      TextEditingController();

  //form is used to get the current state of the field that is used to validate the input for form validation
  final _signUpFormKey = GlobalKey<FormState>();
  List<File> faceImages = [];
  List<File> governmentDocuments = [];
  List<File> medicalDocuments = [];

  void signUpUser() {
    //validating form and after that manually checking if password and confirm password does match or not
    if (_signUpFormKey.currentState!.validate()) {
      //if password and confirm password doesnot match
      if (_passwordController.text != _confirmPasswordController.text) {
        showSnackBar(context, "Password and Confirm Password doesnot matched");
        return;
      }

      if (_signUpFormKey.currentState!.validate() &&
          faceImages.isNotEmpty &&
          governmentDocuments.isNotEmpty &&
          medicalDocuments.isNotEmpty) {
        print("Inside sellproduct function client side");
        authService.signUpUser(
          context: context,
          name: _nameController.text,
          age: int.parse(_ageController.text),
          sex: _sexController.text,
          phoneNumber: _phoneNumberController.text,
          bloodGroup: _bloodGroupController.text,
          address: _addressController.text,
          email: _emailController.text,
          faceImage: faceImages,
          governmentDocument: governmentDocuments,
          medicalDocument: medicalDocuments,
          role: 'recipient',
          status: 'UNVERIFIED',
          password: _passwordController.text,
          lastDonated:_lastDonatedController.text,
          token: '',
          rewardPoints: 0,
        );
      }
      

    }
  }

  void selectFaceImages() async {
    var res = await pickImages();
    setState(() {
      faceImages = res;
    });
  }

  void selectGovernmentDocuments() async {
    var res = await pickImages();
    setState(() {
      governmentDocuments = res;
    });
  }

  void selectmedicalDocuments() async {
    var res = await pickImages();
    setState(() {
      medicalDocuments = res;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          //reason to use the flexiblespace is that we want to have the linear Gradient to the AppBar but AppBar doesnot have the property lineargradiend so we use flexibleSpace
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    "Sign Up Form",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
        child: SingleChildScrollView(
          child: Form(
            key: _signUpFormKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  hintText: "Your full name",
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextField(
                  controller: _ageController,
                  hintText: "Your age",
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextField(
                  controller: _sexController,
                  hintText: "Your sex i.e. Male or Female",
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextField(
                  controller: _phoneNumberController,
                  hintText: "Your Phone Number",
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextField(
                  controller: _bloodGroupController,
                  hintText: "Your Blood Group",
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextField(
                  controller: _addressController,
                  hintText: "Your complete address",
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: "Your email address",
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Your password",
                ),
                const SizedBox(
                  height: 17,
                ),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: "Confirm password",
                ),
                const SizedBox(
                  height: 17,
                ),CustomTextField(
                  controller: _lastDonatedController,
                  hintText: "Last Blood Donated Date i.e. yyyy-mm-dd",
                ),
                const SizedBox(
                  height: 17,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    faceImages.isNotEmpty
                        ? CarouselSlider(
                            items: faceImages.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 100,
                                  ),
                                );
                              },
                            ).toList(), //will return list of widget
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 100,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectFaceImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Upload Face Images",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    governmentDocuments.isNotEmpty
                        ? CarouselSlider(
                            items: governmentDocuments.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 100,
                                  ),
                                );
                              },
                            ).toList(), //will return list of widget
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 100,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectGovernmentDocuments,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Upload Government Identified Documents",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    medicalDocuments.isNotEmpty
                        ? CarouselSlider(
                            items: medicalDocuments.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: 100,
                                  ),
                                );
                              },
                            ).toList(), //will return list of widget
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: 100,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectmedicalDocuments,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Upload Your Medical Documents",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        GlobalVariables.loginSignUpButtonBackgroundColor,
                  ),
                  onPressed: signUpUser,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 21,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
