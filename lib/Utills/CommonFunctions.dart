import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class CommonFunctions
{
  static showToast(String message){
    Fluttertoast.showToast(
        msg: message
    );
  }
  static shareApp(String text) async
  {
    await Share.share(text);
  }
  static Future<bool> internetCheck() async
  {
    bool isConnected = false;
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if(response.isNotEmpty)
      {
        isConnected = true;
      }
      else
        {
          isConnected = false;
        }

    }
    on SocketException catch(err){
      print(err);
      isConnected = false;
      rethrow;
    }
    return isConnected;
  }
}