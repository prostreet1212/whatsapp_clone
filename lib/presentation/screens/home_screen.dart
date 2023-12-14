import 'package:flutter/material.dart';
import 'package:whatsapp_clone/presentation/widgets/custom_tab_bar.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';

import '../pages/calls_page.dart';
import '../pages/camera_page.dart';
import '../pages/chat_page.dart';
import '../pages/status_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearch = false;
  int _currentPageIndex=1;
  PageController _pageViewController=PageController(initialPage: 1);
  List<Widget> _pages=[CameraPage(),ChatPage(),StatusPage(),CallsPage()];

  _buildScreen() {
    return Container(
      margin: EdgeInsets.only(top: 29),
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
          boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.3),
            spreadRadius: 1,
            offset: Offset(0, .50))
      ]),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: InkWell(
              child: Icon(Icons.arrow_back),
              onTap: () {
                setState(() {
                  _isSearch=false;
                });
              },
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: _isSearch == false?primaryColor:Colors.transparent,
        title:_isSearch == false? Text('WhatsApp Clone'):Container(height: 0,width: 0,),
        flexibleSpace: _isSearch == false
            ? Text(
                '',
                style: TextStyle(fontSize: 0),
              )
            : _buildScreen(),
        actions: [
          InkWell(
            child: Icon(Icons.search),
            onTap: (){
              setState(() {
                _isSearch=true;
              });
            },
          ),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.more_vert),
        ],
      ),
      body: Column(
        children: [
          CustomTabBar(index: 0,),
          Expanded(
              child: PageView.builder(
                itemCount: _pages.length,
                  controller: _pageViewController,
                  onPageChanged: (index){
                  setState(() {
                    _currentPageIndex=index;
                  });
                  },
                  itemBuilder: (_,index){
                  return _pages[index];
                  }))
        ],
      ),
    );
  }
}
