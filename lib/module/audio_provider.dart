import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlayerReady = false;
  bool _audioUnavailable = false;

  AudioPlayer get player => _audioPlayer;
  bool get isPlayerReady => _isPlayerReady;

  // True when the current baith has no audio (out of range or failed to load).
  bool get audioUnavailable => _audioUnavailable;

  // Whether an audio file is mapped for the given tab index.
  bool hasAudioFile(int tabIndex) =>
      tabIndex >= 0 && tabIndex < _audioFiles.length;

  // Audio URL base
  static const String audioBaseUrl =
      'https://ervadimawlid.harkcreation.com/audio/';

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

  // Store positions for each track
  final Map<int, Duration> trackPositions = {};
  int _currentTabIndex = -1;

  AudioProvider();

  Future<void> loadAudio(int tabIndex) async {
    // No audio file mapped for this baith.
    if (!hasAudioFile(tabIndex)) {
      _isPlayerReady = false;
      _audioUnavailable = true;
      _currentTabIndex = tabIndex;
      notifyListeners();
      return;
    }
    if (_currentTabIndex == tabIndex && _isPlayerReady) return;

    // Save current position before switching
    if (_currentTabIndex != -1 && _isPlayerReady) {
      trackPositions[_currentTabIndex] = _audioPlayer.position;
    }

    _isPlayerReady = false;
    _audioUnavailable = false;
    _currentTabIndex = tabIndex;
    notifyListeners();

    try {
      final url = '$audioBaseUrl${_audioFiles[tabIndex]}';
      await _audioPlayer.setUrl(url);

      // Restore position if exists
      if (trackPositions.containsKey(tabIndex)) {
        await _audioPlayer.seek(trackPositions[tabIndex]);
      }

      _isPlayerReady = true;
      _audioUnavailable = false;
      notifyListeners();
    } catch (e) {
      print("Error loading audio: $e");
      _isPlayerReady = false;
      _audioUnavailable = true;
      notifyListeners();
      rethrow;
    }
  }

  void play() => _audioPlayer.play();
  void pause() {
    _audioPlayer.pause();
    // Save position on pause as well
    if (_currentTabIndex != -1) {
      trackPositions[_currentTabIndex] = _audioPlayer.position;
    }
  }

  void stop() {
    _audioPlayer.stop();
    if (_currentTabIndex != -1) {
      trackPositions[_currentTabIndex] = Duration.zero;
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
