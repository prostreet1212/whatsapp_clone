import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/presentation/pages/sub_pages/singe_item_chat_user_page.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: 10,
                  itemBuilder: (_,index){
                  return SingleItemChatUserPage( );
                  },))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.chat),
        onPressed: () async{

        },),
    );
  }
}


