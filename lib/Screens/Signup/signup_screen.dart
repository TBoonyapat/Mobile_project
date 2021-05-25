import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/Signup/components/body.dart';
import 'package:mobile_application/DateTimePicker.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Body(),
            // DateTimePicker(),
          ],
        ),
     

      
    );
  }
}
