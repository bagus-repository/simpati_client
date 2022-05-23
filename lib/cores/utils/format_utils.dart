import 'dart:math';

import 'package:intl/intl.dart';

enum RandomType { classId, normal }

enum FormatDateType {reqtime_header, sql, common, common_time, common_dayname, custom}

abstract class FormatUtil {
  static String formatIdDate(FormatDateType type, DateTime? date,
      {String? format}) {
    if (date == null) {
      return '-';
    }
    switch (type) {
      case FormatDateType.reqtime_header:
        format = 'yyyyMMddHms';
        break;
      case FormatDateType.sql:
        format = 'yyyy-MM-dd';
        break;
      case FormatDateType.common:
        format = 'dd-MMM-yyyy';
        break;
      case FormatDateType.common_time:
        format = 'dd-MM-yyyy HH:mm:ss';
        break;
      case FormatDateType.common_dayname:
        format = 'EEEE, dd MMMM yyyy';
        break;
      case FormatDateType.custom:
        format = format;
        break;
    }
    return DateFormat(format).format(date);
  }

  static String formatTextClock() {
    final DateTime now = DateTime.now();
    final DateTime startPagi =
        DateTime(now.year, now.month, now.day, 4, 59, 59);
    final DateTime endPagi = DateTime(now.year, now.month, now.day, 10, 0, 0);

    final DateTime startSiang =
        DateTime(now.year, now.month, now.day, 9, 59, 59);
    final DateTime endSiang = DateTime(now.year, now.month, now.day, 15, 0, 0);

    final DateTime startSore =
        DateTime(now.year, now.month, now.day, 14, 59, 59);
    final DateTime endSore = DateTime(now.year, now.month, now.day, 18, 0, 0);

    final DateTime startMalam =
        DateTime(now.year, now.month, now.day, 17, 59, 59);
    final DateTime endMalam =
        DateTime(now.year, now.month, now.day + 1, 0, 0, 0);

    if (now.isAfter(startPagi) && now.isBefore(endPagi)) {
      return 'Pagi';
    } else if (now.isAfter(startSiang) && now.isBefore(endSiang)) {
      return 'Siang';
    } else if (now.isAfter(startSore) && now.isBefore(endSore)) {
      return 'Sore';
    } else if (now.isAfter(startMalam) && now.isBefore(endMalam)) {
      return 'Malam';
    } else {
      return 'Dini Hari';
    }
  }

  static String formatMoney(double? amount) {
    if (amount == null) {
      return '-';
    }
    return NumberFormat.simpleCurrency(name: '').format(amount);
  }

  static String formatAddress({
    String? street,
    String? name,
    String? subLocality,
    String? locality,
    String? administrativeArea,
    String? postalCode,
    String? country,
  }) {
    return "${street ?? ''}, ${name ?? ''}, ${subLocality ?? ''}, ${locality ?? ''}, ${administrativeArea ?? ''} ${postalCode ?? ''}, ${country ?? ''}";
  }

  static String getRandomString(
      {int? length, RandomType type = RandomType.normal}) {
    if (type == RandomType.classId) {
      length = 5;
    } else {
      length = length ?? 10;
    }
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static int getRandomIntRange(int min, int max) {
    final _random = Random();
    return min + _random.nextInt(max - min);
  }

  static String getRiwayatStatus(int sts) {
    if (sts == 0) {
      return 'Pending';
    }else if (sts == 1) {
      return 'Disetujui';
    }else if (sts == 2) {
      return 'Ditolak';
    } else {
      return '-';
    }
  }
}
