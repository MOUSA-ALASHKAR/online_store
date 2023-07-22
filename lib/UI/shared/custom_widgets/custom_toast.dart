import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_store/UI/shared/utils.dart';
import 'package:online_store/core/enums/message_type.dart';

class CustomToast {

  static showMessage({ required String message ,  MessageType? messageType = MessageType.INFO })
  {
    BotToast.showCustomText(
        duration: Duration(seconds: 2),
        toastBuilder: (value)
        {
          String imageName = 'info';
          Color shadowColor = Colors.blueAccent;

          switch(messageType) {

            case MessageType.INFO:
              imageName = 'info';
              shadowColor = Colors.blueAccent;
              break;

            case MessageType.WARNING:
              imageName = 'warning';
              shadowColor = Colors.orangeAccent;
              break;

            case MessageType.REJECTED:
              imageName = 'rejected';
              shadowColor = Colors.red;
              break;

            case MessageType.SUCCESS:
              imageName = 'approved';
              shadowColor = Colors.greenAccent;
              break;
          }



          return Container(
            width: screenWidth(2),
            height: screenWidth(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('images/$imageName.svg' , width: screenWidth(5),  height: screenWidth(5),),
                SizedBox(height: screenWidth(15),),
                Text(message , style: TextStyle(fontSize: screenWidth(12),),)
              ],
            ),
          );
        }
    );
  }

}