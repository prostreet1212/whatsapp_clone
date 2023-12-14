import 'package:flutter/material.dart';
import 'package:whatsapp_clone/presentation/widgets/theme/style.dart';

class CustomTabBar extends StatelessWidget {
  final int index;

  const CustomTabBar({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: 'CHATS',
              textColor: index == 1? textIconColor  : textIconColorGray,
              borderColor: index == 1?textIconColorGray:Colors.transparent,
              borderWidth: 0,//?
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: 'STATUS',
              textColor: Colors.white,
              borderColor: Colors.transparent,
              borderWidth: 0,
            ),
          ),
          Expanded(
            child: CustomTabBarButton(
              text: 'CALLS',
              textColor: Colors.white,
              borderColor: Colors.transparent,
              borderWidth: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  const CustomTabBarButton({
    Key? key,
    required this.text,
    required this.borderColor,
    required this.textColor,
     required this.borderWidth,
  }) : super(key: key);

  final String text;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: borderColor, width: borderWidth),
      )),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
