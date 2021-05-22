import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/Login/components/background.dart';
import 'package:mobile_application/Screens/Signup/signup_screen.dart';
import 'package:mobile_application/components/already_have_an_account_acheck.dart';
import 'package:mobile_application/components/rounded_button.dart';
import 'package:mobile_application/components/rounded_input_field.dart';
import 'package:mobile_application/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            SizedBox(height: size.height * 0.001),
            SvgPicture.asset(
              "assets/icons/ing.svg",
              height: size.height * 0.3,
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              "Welcome!",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 40
                ),
            ),
            
            SizedBox(height: size.height * 0.05),
            RoundedInputField(
              
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {},
              color: Color(0xFF5F9D6E)
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
