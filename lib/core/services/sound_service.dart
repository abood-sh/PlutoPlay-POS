import 'package:audioplayers/audioplayers.dart';

/// Service for playing sound effects in the POS app
class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  // Pre-cached sources for instant playback
  final AssetSource _successSource = AssetSource('sounds/success.mp3');
  final AssetSource _errorSource = AssetSource('sounds/error.mp3');

  bool _isInitialized = false;

  /// Initialize the sound service
  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;
  }

  /// Play success sound (when item added to cart) - instant, no await
  void playSuccess() {
    if (!_isInitialized) return;

    // Create a new player each time for reliable, instant playback
    final player = AudioPlayer();
    player
        .play(_successSource)
        .then((_) {
          // Dispose after playback completes
          player.onPlayerComplete.first.then((_) {
            player.dispose();
          });
        })
        .catchError((_) {
          player.dispose();
        });
  }

  /// Play error sound (when scan fails) - instant, no await
  void playError() {
    if (!_isInitialized) return;

    // Create a new player each time for reliable, instant playback
    final player = AudioPlayer();
    player
        .play(_errorSource)
        .then((_) {
          // Dispose after playback completes
          player.onPlayerComplete.first.then((_) {
            player.dispose();
          });
        })
        .catchError((_) {
          player.dispose();
        });
  }

  /// Dispose of audio players
  void dispose() {
    _isInitialized = false;
  }
}
