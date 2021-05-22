import 'package:flutter/material.dart';
import 'package:mobile_application/Screens/Login/login_screen.dart';
import 'package:mobile_application/Screens/Signup/components/background.dart';
// import 'package:mobile_application/Screens/Signup/components/or_divider.dart';
// import 'package:mobile_application/Screens/Signup/components/social_icon.dart';
import 'package:mobile_application/components/already_have_an_account_acheck.dart';
import 'package:mobile_application/components/rounded_button.dart';
import 'package:mobile_application/components/rounded_input_field.dart';
import 'package:mobile_application/components/rounded_password_field.dart';
import 'package:mobile_application/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/tooyen.svg",
              height: size.height * 0.3,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "SIGNUP",
              style: TextStyle(
                color: kPrimaryColor,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 40
                ),
                
            ),
             SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
              color: Color(0xFF5F9D6E)
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocalIcon(
            //       iconSrc: "assets/icons/facebook.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/twitter.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/google-plus.svg",
            //       press: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
