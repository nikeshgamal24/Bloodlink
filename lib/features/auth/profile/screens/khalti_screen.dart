import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:test/features/auth/profile/screens/khalti_page_ui.dart';

class MyKhaltiScreen extends StatelessWidget {
  static const String routeName = '/khali';
  const MyKhaltiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_bc29bf31d1a94744906ae1f1518d66ab",
        enabledDebugging: true,
        builder: (context, navKey) {
          return MaterialApp(
            title: 'Khalti Payment',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            home: const KhaltiPageUI(),
            navigatorKey: navKey,
             localizationsDelegates: [
      KhaltiLocalizations.delegate,
      // Add this line
    // Add other localization delegates if needed
  ],
          );
        });
  }
}