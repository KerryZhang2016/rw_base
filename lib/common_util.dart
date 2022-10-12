
class CommonUtil {
  static T? lastOrNull<T>(List<T?> data) {
    return data.isNotEmpty == true ? data.last : null;
  }

  static T? firstOrNull<T>(List<T?> data) {
    return data.isNotEmpty == true ? data.first : null;
  }
}