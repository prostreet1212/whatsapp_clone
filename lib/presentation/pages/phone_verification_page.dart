import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../widgets/theme/style.dart';


class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                Text(
                  'Verify your phone number',
                  style: TextStyle(
                      fontSize: 18,
                      color: greenColor,
                      fontWeight: FontWeight.w500),
                ),
                Icon(Icons.more_vert)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'WhatsApp Clone will send and SMS message (carrier charges may apply) to verify your phone number. Enter your country code and phone number:',
              style: TextStyle(fontSize: 16),
            ),
            _pinCodeWidget(),
            Expanded(
              child: Align(
                alignment:Alignment.bottomCenter,
                child: MaterialButton(
                  color: greenColor,
                  child: Text('Next',style: TextStyle(fontSize: 18,color: Colors.white),),
                  onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (_)=>PhoneVerificationPage()));
                  },
                ),
              ),),
          ],
        ),
      ),
    );
  }

  Widget _pinCodeWidget() {
    return Container(
      child: PinCodeTextField(
        controller: _pinCodeController,
        length: 6,
        obscureText: true,
        onChanged: (pinCode){
          print(pinCode);
        },

      ),
    );
  }
}
