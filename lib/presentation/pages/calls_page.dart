import 'package:flutter/material.dart';
import 'package:whatsapp_clone/presentation/pages/sub_pages/single_item_call_page.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
          itemBuilder: (context,index){
          return SingleItemCallPage();
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add_call,color: Colors.white,),
        onPressed: (){},
      ),
    );
  }
}