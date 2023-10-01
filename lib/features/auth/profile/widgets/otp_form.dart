import 'package:flutter/material.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/features/auth/profile/services/my_created_requests_service.dart';
import 'package:test/features/auth/profile/widgets/otp_custom_textfield.dart';

class OTPCodeForm extends StatefulWidget {
  final String reqId;
  const OTPCodeForm({
    super.key,
    required this.reqId,
  });

  @override
  State<OTPCodeForm> createState() => _OTPCodeFormState();
}

class _OTPCodeFormState extends State<OTPCodeForm> {
  final MyCreatedRequestService myCreatedRequestService =
      MyCreatedRequestService();
  final TextEditingController otpController = TextEditingController();
  final _otpCodeFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  void validateOTP(String otp) {
    if (_otpCodeFormKey.currentState!.validate()) {
      myCreatedRequestService.verifyOTPCode(context, widget.reqId, otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _otpCodeFormKey,
          child: OTPCustomTextField(
            controller: otpController,
            hintText: "Enter your otp code",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalVariables.buttonBackgroundColor,
          ),
          onPressed: () {
            validateOTP(otpController.text);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              "Submit OTP Code",
              style: TextStyle(
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
