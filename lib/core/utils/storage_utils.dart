class StorageUtils {
  static const double gb = 1024 * 1024 * 1024;

  static double bytesToGb(num bytes) => bytes / gb;

  static double bytoToGb(int bytes) {
    return (bytes / (1024 * 1024 * 1024));
  }

  static String formatGb(double gb, {int fractionDigits = 2}) =>
      gb.toStringAsFixed(fractionDigits);
}