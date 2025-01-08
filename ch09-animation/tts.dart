// Add dependency
/* flutter pub add flutter_tts */

// main.dart
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  FlutterTts flutterTts = FlutterTts();
  
  // Await speak completion
  await flutterTts.awaitSpeakCompletion(true);

  // Await SynthesizeToFile completion
  await flutterTts.awaitSynthesizeToFileCompletion(true);

  /** Usages:
    *   speak
    *   stop
    *   getLanguages
    *   setLanguage
    *   setSpeechRate
    *   getVoices
    *   setVoice
    *   setVolume
    *   setPitch
    *   isLanguageAvailable
    *   setSharedInstance
    */
  // Example of speak
  await flutterTts.speak("Yoo!");
}