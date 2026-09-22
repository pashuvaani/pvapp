class VideoCallService {
  bool _isMuted = false;
  bool _isCameraOff = false;

  bool get isMuted => _isMuted;
  bool get isCameraOff => _isCameraOff;

  void toggleMute() {
    _isMuted = !_isMuted;
  }

  void toggleCamera() {
    _isCameraOff = !_isCameraOff;
  }

  Future<void> endCall() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
