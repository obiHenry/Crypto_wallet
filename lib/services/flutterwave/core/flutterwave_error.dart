class FlutterWaveError implements Exception {
  String message;

  FlutterWaveError(this.message);

  String toString() {
    return "Flutterwave Error: ${this.message}";
  }
}
