import 'package:flutter/material.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/presentation/widgets/custom_tab_bar.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';

import '../pages/calls_page.dart';
import '../pages/camera_page.dart';
import '../pages/chat_page.dart';
import '../pages/status_page.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity userInfo;

  const HomeScreen({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearch = false;
  int _currentPageIndex = 1;
  PageController _pageViewController = PageController(initialPage: 1);

  List<Widget> get _pages => [
        CameraPage(),
        ChatPage(
          userInfo: widget.userInfo,
        ),
        StatusPage(),
        CallsPage()
      ];

  _buildScreen() {
    return Container(
      margin: EdgeInsets.only(top: 29),
      height: 48,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                  _isSearch = false;
                });
              },
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentPageIndex != 0
          ? AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor:
                  _isSearch == false ? primaryColor : Colors.transparent,
              title: _isSearch == false
                  ? Text('WhatsApp Clone')
                  : Container(
                      height: 0,
                      width: 0,
                    ),
              flexibleSpace: _isSearch == false
                  ? Text(
                      '',
                      style: TextStyle(fontSize: 0),
                    )
                  : _buildScreen(),
              actions: [
                InkWell(
                  child: Icon(Icons.search),
                  onTap: () {
                    setState(() {
                      _isSearch = true;
                    });
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.more_vert),
              ],
            )
          : null,
      body: Column(
        children: [
          _isSearch == false
              ? _currentPageIndex != 0
                  ? CustomTabBar(
                      index: _currentPageIndex,
                    )
                  : Container()
              : Container(),
          Expanded(
              child: PageView.builder(
                  itemCount: _pages.length,
                  controller: _pageViewController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return _pages[index];
                  }))
        ],
      ),
    );
  }
}
