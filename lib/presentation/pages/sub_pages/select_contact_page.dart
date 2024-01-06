import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_clone/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone/domain/entities/user_entity.dart';
import 'package:whatsapp_clone/presentation/bloc/get_device_number/get_device_number_cubit.dart';
import 'package:whatsapp_clone/presentation/bloc/get_device_number/get_device_number_state.dart';
import 'package:whatsapp_clone/presentation/bloc/user/user_cubit.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';

class SelectContactPage extends StatefulWidget {
  final UserEntity userInfo;

  const SelectContactPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<SelectContactPage> createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {

  @override
  void initState() {
    BlocProvider.of<GetDeviceNumberCubit>(context).getDeviceNumbers();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDeviceNumberCubit, GetDeviceNumbersState>(
        builder: (context, contectNumberState) {
      if (contectNumberState is GetDeviceNumbersLoaded) {
        return BlocBuilder<UserCubit, UserState>(builder: (context, userState) {
          if (userState is UserLoaded) {
            final List<ContactEntity> contacts = [];
            final dbUsers = userState.users
                .where((user) => user.uid != widget.userInfo.uid)
                .toList();
            contectNumberState.contacts.forEach((deviceUserNumber) {
              dbUsers.forEach((dbUserNumber) {
                if (dbUserNumber.phoneNumber ==
                    deviceUserNumber.phoneNumber.replaceAll(' ', '')) {
                  contacts.add(ContactEntity(
                      phoneNumber: dbUserNumber.phoneNumber,
                      label: dbUserNumber.name,
                      uid: dbUserNumber.uid,
                      status: dbUserNumber.status));
                }
              });
            });
            return Scaffold(
              appBar: AppBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Contact'),
                    Text(
                      '${contacts.length} contacts',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                actions: [Icon(Icons.search), Icon(Icons.more_vert)],
              ),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    _newGroupButtonWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    _newContactButtonWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    _listContact(contacts),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
      }
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget _newGroupButtonWidget() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Icon(
              Icons.people,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            'New Group',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _newContactButtonWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'New contact',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Icon(
            FontAwesomeIcons.qrcode,
            color: greenColor,
          )
        ],
      ),
    );
  }

  Widget _listContact(List<ContactEntity> contacts) {
    return Expanded(
        child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  BlocProvider.of<UserCubit>(context)
                      .createChatChannel(uid: widget.userInfo.uid,
                      otherUid: contacts[index].uid);
                  
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Image.asset('assets/profile_default.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${contacts[index].label}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),

                            ),
                            SizedBox(height: 5,),
                            Text('hi there i\'m using this app',overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
