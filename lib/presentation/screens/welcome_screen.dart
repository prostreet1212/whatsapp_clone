import 'package:flutter/material.dart';
import 'package:whatsapp_clone/presentation/screens/registration_screen.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Welcome to WhatsApp Clone',
              style: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 290,
              width: 290,
              child: Image.asset('assets/brand.png'),
            ),
            Column(
              children: [
                Text(
                  'Read our Privacy Policy Tap, \'Agree and continue\' to accept the Terms of Service',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                    color: greenColor,
                    child: Text(
                      'AGREE AND CONTINUE',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegistrationScreen(),
                        ),
                      );
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
