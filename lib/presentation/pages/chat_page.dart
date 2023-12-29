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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(.5),
              borderRadius: BorderRadius.all(Radius.circular(100),
              ),
            ),
            child: Icon(
              Icons.message,
              color: Colors.white.withOpacity(.6),
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              child: Text('Start chat with your friends and family\n on Whatsapp Clone',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14,color: Colors.black.withOpacity(.4)),),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.chat),
        onPressed: () async {},
      ),
    );
  }

  Widget _myChatList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return SingleItemChatUserPage();
        },
      ),
    );
  }
}
