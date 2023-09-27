import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:test/common/widgets/blood_request_textfield.dart';
import 'package:test/constants/global_variables.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:test/constants/utils.dart';
import 'package:test/features/auth/form/bloodRequestForm/bloodrequest_form_service.dart';
import 'package:test/providers/user_provider.dart';

class BloodRequesCreateForm extends StatefulWidget {
  static const String routeName = '/create-blood-request';
  const BloodRequesCreateForm({Key? key}) : super(key: key);

  @override
  State<BloodRequesCreateForm> createState() => _BloodRequesCreateForm();
}

class _BloodRequesCreateForm extends State<BloodRequesCreateForm> {
  final BloodRequestService bloodRequestService = BloodRequestService();
   late IO.Socket socket;
  String? userEmail;

  // Define controllers for form fields
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _recipientBloodGroupController =
      TextEditingController();
  final TextEditingController _requiredPintsController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _bloodRequiredDateController =
      TextEditingController();
  final TextEditingController _caseOfRequestController =
      TextEditingController();
  // final TextEditingController _contactOfRequestCreatorController =
  //     TextEditingController();
  // final TextEditingController _phoneNumberOfRequestCreatorController =
  //     TextEditingController();
  final _createBloodRequestFormKey = GlobalKey<FormState>();

  void createCampaign() {
    //validating form and after that manually checking if password and confirm password does match or not
    if (_createBloodRequestFormKey.currentState!.validate()) {
//checking for valid ward number
      print("=================city==========");
      print(_cityController.text.toLowerCase());
      switch (_cityController.text.toLowerCase()) {
        case "kathmandu":
          if (int.parse(_wardController.text) <= 0 ||
              int.parse(_wardController.text) > 32) {
            showSnackBar(
                context, "Invalid Ward number for Kathmandu!Out of bound");
            return;
          }
          break;
        case "lalitpur":
          if (int.parse(_wardController.text) <= 0 ||
              int.parse(_wardController.text) > 29) {
            showSnackBar(
                context, "Invalid Ward number for Lalitpur!Out of bound");
            return;
          }
          break;
        case "bhaktapur":
          if (int.parse(_wardController.text) <= 0 ||
              int.parse(_wardController.text) > 17) {
            showSnackBar(
                context, "Invalid Ward number for Bhaktapur!Out of bound");
            return;
          }
          break;
        default:
          if (int.parse(_wardController.text) <= 0 ||
              int.parse(_wardController.text) > 79) {
            showSnackBar(context, "Invalid ward number number!Out of bound");
            return;
          }
      }

      bloodRequestService.createBloodRequest(
        context: context,
        recipientName: _recipientNameController.text,
        recipientBloodGroup: _recipientBloodGroupController.text,
        requiredPints: int.tryParse(_requiredPintsController.text),
        otp: int.tryParse(_otpController.text),
        hospitalName: _hospitalNameController.text,
        streetName: _streetNameController.text,
        postalCode: int.parse(_postalCodeController.text),
        ward: int.parse(_wardController.text),
        city: _cityController.text,
        country: _countryController.text,
        longitude: double.tryParse(_longitudeController.text),
        latitude: double.tryParse(_latitudeController.text),
        bloodRequiredDate: _bloodRequiredDateController.text,
        caseOfRequest: _caseOfRequestController.text,
        contactOfRequestCreator: '',
        //will be populated at backend : contact of user that make request
        phoneNumberOfRequest: 0,
        // phonenumber of user that created the blood request
        acceptors: [],
        //
      );

      socket = IO.io(uri, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });
      // Initialize geolocation
      Geolocator.getPositionStream(
              desiredAccuracy: LocationAccuracy.best, distanceFilter: 10)
          .listen((Position position) {
        // print('Location data: ${position.latitude}, ${position.longitude}');
        // Send location data to the server
        socket.emit('location', {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'email': userEmail,
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userEmail = Provider.of<UserProvider>(context).user.email;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Fill BLood Request Form",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                  size: 32,
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
        child: SingleChildScrollView(
          child: Form(
            key: _createBloodRequestFormKey,
            child: Column(
              children: [
                BloodRequestCustomTextField(
                  controller: _recipientNameController,
                  hintText: "Recipient Name",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _recipientBloodGroupController,
                  hintText: "Recipient Blood Group",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _requiredPintsController,
                  hintText: "Required Pints",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _hospitalNameController,
                  hintText: "Enter Hospital Name",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _streetNameController,
                  hintText: "Enter Street Name",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _postalCodeController,
                  hintText: "Enter Postal Code",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _wardController,
                  hintText: "Enter Ward Number",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _cityController,
                  hintText: "Enter City",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _countryController,
                  hintText: "Enter Country",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _bloodRequiredDateController,
                  hintText: "Enter Required Date i.e. yyyy-mm-dd",
                ),
                const SizedBox(
                  height: 17,
                ),
                BloodRequestCustomTextField(
                  controller: _caseOfRequestController,
                  hintText: "Enter Case of request",
                ),
                const SizedBox(
                  height: 17,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalVariables.buttonBackgroundColor,
                  ),
                  onPressed: createCampaign,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "Create Blood Request",
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
