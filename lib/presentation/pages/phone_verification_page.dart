import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:whatsapp_clone/presentation/bloc/phone_auth/phone_auth_cubit.dart';
import 'package:whatsapp_clone/presentation/pages/set_initial_profile_page.dart';

import '../widgets/theme/style.dart';


class PhoneVerificationPage extends StatefulWidget {
  final String phoneNumber;
  const PhoneVerificationPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  String get _phoneNumber=>widget.phoneNumber;
  TextEditingController _pinCodeController=TextEditingController();
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
            _pinCodeWidget(context),
            Expanded(
              child: Align(
                alignment:Alignment.bottomCenter,
                child: MaterialButton(
                  color: greenColor,
                  child: Text('Next',style: TextStyle(fontSize: 18,color: Colors.white),),
                  onPressed: _submitSmsCode,
                ),
              ),),
          ],
        ),
      ),
    );
  }

  Widget _pinCodeWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50,),
      child: Column(
        children: [
          PinCodeTextField(
            controller: _pinCodeController,
            length: 6,
            backgroundColor: Colors.transparent,
            obscureText: true,
            onChanged: (pinCode){
              print(pinCode);
            }, appContext: context,
          ),
          Text('Enter your 6 digit code'),
        ]
      ),
    );
  }
  
  void _submitSmsCode(){
    if(_pinCodeController.text.isNotEmpty){
      BlocProvider.of<PhoneAuthCubit>(context).submitSmsCode(smsCode: _pinCodeController.text);
    }
  }


}
