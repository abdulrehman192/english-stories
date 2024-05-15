import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TextToSpeechController extends GetxController
{
  bool _play = false;
  //getter
  bool get play => _play;
  //setter
  set play(bool val)
  {
    _play = val;
  }
  FlutterTts flutterTts = FlutterTts();
  textToSpeechUk(String text) async
  {
    if(!_play)
    {
      await flutterTts.setPitch(0.5);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setLanguage("en/GB");
      await flutterTts.speak(text);
      _play = true;
      update();
    }
    else
      {
        await flutterTts.stop();
        _play = false;
        update();
      }
  }
  @override
  void dispose()
  {
    flutterTts.stop();
    super.dispose();
  }
}