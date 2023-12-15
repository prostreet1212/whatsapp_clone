import 'package:flutter/material.dart';
import 'package:whatsapp_clone/presentation/pages/sub_pages/single_item_story_page.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Stack(
          children: [
            _customFloatingActionButton(),
            SingleChildScrollView(
              child: Column(
                children: [
                  _storyWidget(),
                  SizedBox(height: 8),
                  _recentTextWidget(),
                  SizedBox(height: 8),
                  _listStories(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customFloatingActionButton() {
    return Positioned(
        right: 10,
        bottom: 15,
        child: Column(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 0.5,
                        color: Colors.black.withOpacity(.2),
                        spreadRadius: 0.1)
                  ]),
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 0.5,
                        color: Colors.black.withOpacity(.2),
                        spreadRadius: 0.1)
                  ]),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }

  Widget _storyWidget() {
    return Container(
      margin: EdgeInsets.only(left: 10,right:10,top: 4 ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Image.asset('assets/profile_default.png'),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 2,),
              Text('Tap to add status update')
            ],
          )
        ],
      ),
    );
  }

  Widget _recentTextWidget() {
   return Container(
     width: double.infinity,
     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
     decoration: BoxDecoration(
       color: Colors.grey[200]
     ),
     child: Text('Recent updates'),
   );
  }

  Widget _listStories() {
    return ListView.builder(
        itemCount: 10,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context,index){
          return SingleItemStoryPage();
          });
  }
}
