import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/presentation/bloc/my_chat/my_chat_cubit.dart';
import 'package:whatsapp_clone/presentation/pages/sub_pages/select_contact_page.dart';
import 'package:whatsapp_clone/presentation/pages/sub_pages/singe_item_chat_user_page.dart';
import 'package:whatsapp_clone/presentation/pages/sub_pages/single_communication_page.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';

class ChatPage extends StatefulWidget {
  final UserEntity userInfo;
  const ChatPage({Key? key,required this.userInfo}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyChatCubit>(context).getMyChat(uid: widget.userInfo.uid);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<MyChatCubit,MyChatState>(
        builder: (_,myChatState){
          if(myChatState is MyChatLoaded){
            return _myChatList(myChatState);
          }
          return _loadingWidget();

        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.chat),
        onPressed: ()  {
Navigator.push(context, MaterialPageRoute(builder: (_)=>SelectContactPage(userInfo: widget.userInfo)));
        },
      ),
    );
  }


  Widget _emptyListDisplayMessageWidget(){
    return  Column(
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
      );
  }

  Widget _myChatList(MyChatLoaded myChatData) {
    return  myChatData.myChat.isEmpty
          ?_emptyListDisplayMessageWidget()
          :ListView.builder(
        itemCount: myChatData.myChat.length,
        itemBuilder: (_, index) {
          final myChat=myChatData.myChat[index];
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)
              =>SingleCommunicationPage(
                  senderUID: myChat.senderUID,
                  recipientUID: myChat.recipientUID,
                  senderName: myChat.senderName,
                  recipientName: myChat.recipientName,
                  recipientPhoneNumber: myChat.recipientPhoneNumber,
                  senderPhoneNumber: myChat.senderPhoneNumber)));
            },
            child: SingleItemChatUserPage(
              name: myChat.recipientName,
              recentSendMessage: myChat.recentTextMessage,
              time: DateFormat('hh:mm a').format(myChat.time.toDate()),
            ),
          );
        },
      );
  }

  Widget _loadingWidget(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }


}
