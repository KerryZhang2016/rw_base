// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';
import 'package:rw_base/generated/l10n.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

/// DateFormat.
/// format 转换格式(已提供常用格式 DataFormats，可以自定义格式："yyyy/MM/dd HH:mm:ss")
/// 格式要求
/// year -> yyyy/yy   month -> MM/M    day -> dd/d
/// hour -> HH/H      minute -> mm/m   second -> ss/s
class DateFormats {
  static const String YYYY_MM_DD_HH_MM_SS = "yyyy/MM/dd HH:mm:ss";
  static const String YYYY_MM_DD_HH_MM = "yyyy/MM/dd HH:mm";
  static const String YYYY_MM_DD = "yyyy/MM/dd";
  static const String YYYY_MM_DD2 = "yyyy-MM-dd";
  static const String YYYYMMDD = "yyyyMMdd";
  static const String YYYY_MM = "yyyy/MM";
  static const String MM_DD = "MM/dd";
  static const String MM_DD_HH_MM_SS = "MM/dd HH:mm:ss";
  static const String MM_DD_HH_MM = "MM/dd HH:mm";
  static const String HH_MM_SS = "HH:mm:ss";
  static const String HH_MM = "HH:mm";
}

/// month->days.
const Map<int, int> MONTH_DAY = {
  1: 31,
  2: 28,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31,
};

/// Date Util.
class DateUtil {
  static const int TIME_MILLIS_IN_ONE_MINUTE = 60 * 1000;
  static const int TIME_MILLIS_IN_ONE_HOUR = TIME_MILLIS_IN_ONE_MINUTE * 60;
  static const int TIME_MILLIS_IN_ONE_DAY = TIME_MILLIS_IN_ONE_HOUR * 24;
  static const int TIME_MILLIS_IN_ONE_WEEK = TIME_MILLIS_IN_ONE_DAY * 7;
  static const int TIME_MILLIS_IN_ONE_MONTH = TIME_MILLIS_IN_ONE_DAY * 30;

  static bool _isDST = false;// 当前是否是夏令时

  /// 获取当前的时间戳
  static int getNowDateMs() => DateTime.now().millisecondsSinceEpoch;

  /// 初始化Time Zone
  static void initTimeZones() {
    initializeTimeZones();
    // 判断夏令时
    final detroit = getLocation('America/New_York');
    TZDateTime now = TZDateTime.now(detroit);
    if (now.timeZoneOffset.inHours == -5) {
      _isDST = false;
    } else {
      _isDST = true;
    }
  }

  static bool isDST() => _isDST;

  /// DateTime -> yyyy/MM/dd
  static String formatDateTime(DateTime dateTime) {
    String y = _fourDigits(dateTime.year);
    String m = _twoDigits(dateTime.month);
    String d = _twoDigits(dateTime.day);
    return "$y/$m/$d";
  }

  /// yyyy/MM/dd -> DateTime（本地时区）
  static DateTime toDateTime(String date) {
    try {
      var year = int.parse(date.substring(0, 4));
      var month = int.parse(date.substring(5, 7));
      var day = int.parse(date.substring(8, 10));
      return DateTime(year, month, day);
    } catch (error) {
      return DateTime.now();
    }
  }

  /// 时间戳 -> DateTime(本地时区)
  static DateTime getDateTimeByMs(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: false);
  }

  /// 时间戳 -> 日期
  /// [milliseconds] 日期毫秒
  /// [format] 日期格式
  /// [timeZoneOffsetInHour] 转换日期对应时区相对UTC时区的offset，eg:中国为 8
  static String formatDateMs(int milliseconds, String format, [int timeZoneOffsetInHour = 8]) {
    milliseconds += timeZoneOffsetInHour * TIME_MILLIS_IN_ONE_HOUR;
    var dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true);
    return DateFormat(format).format(dateTime);
  }

  /// 日期 -> 时间戳
  static int getDateMsByTimeStr(String dateStr, {int timeZoneOffsetInHour = 8}) {
    DateTime? dateTime = DateTime.tryParse(dateStr.replaceAll("/", "-"));// 转换成本机时间
    int localTimeZoneOffsetInHour = dateTime?.timeZoneOffset.inHours ?? 0;// 本机时间与UTC时区的offset
    return dateTime == null ? 0
        : dateTime.millisecondsSinceEpoch + (localTimeZoneOffsetInHour - timeZoneOffsetInHour) * TIME_MILLIS_IN_ONE_HOUR;
  }

  /// 日期 -> 日期
  /// [dateStr] 日期字符串
  /// [fromTimeZoneOffsetInHour] 日期字符串的时区
  /// [format] 转换的格式
  /// [toTimeZoneOffsetInHour] 转换的时区
  static String formatDateStr(String dateStr, int fromTimeZoneOffsetInHour, String format, int toTimeZoneOffsetInHour) {
    var milliseconds = getDateMsByTimeStr(dateStr, timeZoneOffsetInHour: fromTimeZoneOffsetInHour);
    return formatDateMs(milliseconds, format, toTimeZoneOffsetInHour);
  }

  /// Return whether it is leap year. 闰年
  static bool isLeapYearByDateTime(DateTime dateTime) {
    return isLeapYearByYear(dateTime.year);
  }

  /// Return whether it is leap year.
  static bool isLeapYearByYear(int year) {
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
  }

  /// is yesterday by millis.
  /// 是否是昨天.
  static bool isYesterdayByMillis(int millis, int locMillis) {
    return isYesterday(DateTime.fromMillisecondsSinceEpoch(millis),
        DateTime.fromMillisecondsSinceEpoch(locMillis));
  }

  /// is yesterday by dateTime.
  /// 是否是昨天.
  static bool isYesterday(DateTime dateTime, DateTime locDateTime) {
    if (yearIsEqual(dateTime, locDateTime)) {
      int spDay = getDayOfYear(locDateTime) - getDayOfYear(dateTime);
      return spDay == 1;
    } else {
      return ((locDateTime.year - dateTime.year == 1) &&
          dateTime.month == 12 &&
          locDateTime.month == 1 &&
          dateTime.day == 31 &&
          locDateTime.day == 1);
    }
  }

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYearByMillis(int millis, {bool isUtc = false}) =>
      getDayOfYear(DateTime.fromMillisecondsSinceEpoch(millis, isUtc: isUtc));

  /// get day of year.
  /// 在今年的第几天.
  static int getDayOfYear(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int days = dateTime.day;
    for (int i = 1; i < month; i++) {
      days = days + MONTH_DAY[i]!;
    }
    if (isLeapYearByYear(year) && month > 2) {
      days = days + 1;
    }
    return days;
  }

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqualByMillis(int millis, int locMillis) =>
      yearIsEqual(DateTime.fromMillisecondsSinceEpoch(millis), DateTime.fromMillisecondsSinceEpoch(locMillis));

  /// year is equal.
  /// 是否同年.
  static bool yearIsEqual(DateTime dateTime, DateTime locDateTime) =>
      dateTime.year == locDateTime.year;

  /// is today.
  /// 是否是当天.
  static bool isToday(int? milliseconds, {bool isUtc = false}) {
    if (milliseconds == null || milliseconds == 0) return false;
    DateTime old = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    DateTime now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    return old.year == now.year && old.month == now.month && old.day == now.day;
  }

  /// is Week.
  /// 是否是本周.
  static bool isWeek(int? milliseconds, {bool isUtc = false}) {
    if (milliseconds == null || milliseconds <= 0) {
      return false;
    }
    DateTime _old = DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: isUtc);
    DateTime _now = isUtc ? DateTime.now().toUtc() : DateTime.now().toLocal();
    DateTime old = _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _old : _now;
    DateTime now = _now.millisecondsSinceEpoch > _old.millisecondsSinceEpoch ? _now : _old;
    return (now.weekday >= old.weekday) &&
        (now.millisecondsSinceEpoch - old.millisecondsSinceEpoch <=
            7 * 24 * 60 * 60 * 1000);
  }

  static String _fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  /// get ZH WeekDay By Milliseconds.
  static String? getZHWeekDayByMs(int milliseconds) {
    DateTime dateTime = getDateTimeByMs(milliseconds);
    return getZHWeekDay(dateTime);
  }

  /// get ZH WeekDay.
  static String? getZHWeekDay(DateTime? dateTime) {
    if (dateTime == null) return null;
    String? weekday;
    switch (dateTime.weekday) {
      case 1:
        weekday = S.current.base_monday;
        break;
      case 2:
        weekday = S.current.base_tuesday;
        break;
      case 3:
        weekday = S.current.base_wednesday;
        break;
      case 4:
        weekday = S.current.base_thursday;
        break;
      case 5:
        weekday = S.current.base_friday;
        break;
      case 6:
        weekday = S.current.base_saturday;
        break;
      case 7:
        weekday = S.current.base_sunday;
        break;
      default:
        break;
    }
    return weekday;
  }
}