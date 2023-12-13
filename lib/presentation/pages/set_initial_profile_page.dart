import 'package:flutter/material.dart';
import 'package:whatsapp_clone/presentation/screens/home_screen.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';

class SetInitialProfilePage extends StatefulWidget {
  const SetInitialProfilePage({Key? key}) : super(key: key);

  @override
  State<SetInitialProfilePage> createState() => _SetInitialProfilePageState();
}

class _SetInitialProfilePageState extends State<SetInitialProfilePage> {

  TextEditingController _nameController=TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Text(
              'Profile Info',
              style: TextStyle(
                color: greenColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please provide your name and an optional Profile photo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _rowWidget(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: greenColor,
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowWidget() {
    return Container(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: textIconColorGray,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            width: 50,
            height: 50,
            child: Icon(
              Icons.camera_alt,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Enter your name'),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 35,
            height:35,
            decoration: BoxDecoration(
              color: textIconColorGray,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Icon(Icons.insert_emoticon),
          )
        ],
      ),
    );
  }
}
