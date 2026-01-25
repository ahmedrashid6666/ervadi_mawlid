import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlayerReady = false;

  AudioPlayer get player => _audioPlayer;
  bool get isPlayerReady => _isPlayerReady;

  // Audio URL base
  static const String audioBaseUrl =
      'https://ervadimawlid.harkcreation.com/ervadimawlid/audio/';

  // Audio filenames mapping to tab indices (1-indexed based on baith number)
  final List<String> _audioFiles = [
    'baith_1.mp3', // مُرَادِي بَيت
    'baith_2.mp3', // أَيَا مَحْبُوب
    'baith_3.mp3', // يٰا وَلِي سَلَامْ عَلَيْكُم
    'baith_4.mp3', // أَيٰا سٰامِي لَدَى الْقٰادِرْ
    'baith_5.mp3', // عَبَّاسْ مَنْترِي بَيت
    'baith_6.mp3', // صَلٰوةٌ وَتَسْلِيمٌ
    'baith_7.mp3', // دُعــــآء
    'baith_8.mp3', // يَا أَكْرَمَ الْخَلْقِ
    'baith_9.mp3', // وَاهًا لِلْقُبَّةِ الْخَضْرَاءِ
  ];

  AudioProvider();

  Future<void> loadAudio(int tabIndex) async {
    if (tabIndex < 0 || tabIndex >= _audioFiles.length) return;

    _isPlayerReady = false;
    notifyListeners();

    try {
      final url = '$audioBaseUrl${_audioFiles[tabIndex]}';
      await _audioPlayer.setUrl(url);
      _isPlayerReady = true;
      notifyListeners();
    } catch (e) {
      print("Error loading audio: $e");
      _isPlayerReady = false;
      notifyListeners();
    }
  }

  void play() => _audioPlayer.play();
  void pause() => _audioPlayer.pause();
  void stop() => _audioPlayer.stop();

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
