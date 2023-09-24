import 'package:flutter/material.dart';
import 'package:test/constants/global_variables.dart';
import 'package:test/features/auth/form/campaignForm/screens/campaign_form.dart';

class CreateScreen extends StatelessWidget {
  static const String routeName = '/create-screen';
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {

  void navigationToCreateCampaign(){
      Navigator.pushNamed(context, CampaignCreateForm.routeName);
  }


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
              Container(
                // color: Colors.transparent,
                // height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: const Text(
                  "Create Screen",
                  style:  TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                )
              ),
              Container(
                // color: Colors.transparent,
                // height: 42,
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
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:Column(
            children:[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalVariables.buttonBackgroundColor,
              ),
              onPressed: () {},
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
           const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalVariables.buttonBackgroundColor,
              ),
              onPressed: navigationToCreateCampaign,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Create Campaign",
                  style: TextStyle(
                    fontSize: 21,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          ) 
        ),
      ),
    );
  }
}
