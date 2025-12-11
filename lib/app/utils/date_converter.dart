
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
  }

  static String dateToTimeOnly(DateTime dateTime) {
    return DateFormat(_timeFormatter()).format(dateTime);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String dateToDateAndTimeAm(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd ${_timeFormatter()}').format(dateTime);
  }

  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}')
        .format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('yyyy-MM-dd')
        .format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd').parse(dateTime);
  }

  static DateTime dateTimeToDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').parse(dateTime.toString());
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static String isoStringToDateTimeString(String dateTime) {
    return DateFormat('dd/MM/yyyy  ${_timeFormatter()}')
        .format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDayOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String stringToLocalDateOnlyM(String dateTime) {
    return DateFormat('dd MMMM yyyy')
        .format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String chatToLocalDateOnly(String dateString) {
    List<String> dateParts = dateString.split('-');

    int year = int.tryParse(dateParts[0]) ?? 0;
    int month = int.tryParse(dateParts[1]) ?? 0;
    int day = int.tryParse(dateParts[2]) ?? 0;

    DateTime inputDate = DateTime(year, month, day);
    DateTime now = DateTime.now();
    if (inputDate.year == now.year) {
      return DateFormat('dd MMM').format(inputDate); // Format without year
    } else {
      // If the year is different, include the year in the formatted date
      return DateFormat('dd MMM yyyy').format(inputDate); // Format with year
    }
  }

  static String stringToLocalDateTime(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS')
        .format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String convertTimeToTime(String time) {
    return DateFormat(_timeFormatter()).format(DateFormat('HH:mm').parse(time));
  }

  static DateTime convertStringTimeToDate(String time) {
    return DateFormat('HH:mm').parse(time);
  }

  static String _timeFormatter() {
    return 'hh:mm a';
    //Get.find<SplashController>().configModel.timeformat == '24' ? 'HH:mm' : 'hh:mm a';
  }

  static String timeOfDayToString(TimeOfDay tod, {format24 = false}) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat(format24 ? 'HH:mm' : 'hh:mm a');
    return format.format(dt);
  }

  /*  static DateTime chatToDateOnly(Timestamp timestamp) {
    var dt = timestamp.toDate();
    log(dt.toString());
    var dtOnly = DateTime(dt.year, dt.month, dt.day, dt.hour, dt.minute);
    return DateFormat('yyyy-MM-dd HH:mm').parse(dtOnly.toString());
  } */

  static DateTime chatToDateAndHM(int timestamp) {
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var dtOnly = DateTime(dt.year, dt.month, dt.day, dt.hour);
    return DateFormat('yyyy-MM-dd HH:mm').parse(dtOnly.toString());
  }

  static String dateTimeStringToMounthOnly(String dateTime) {
    return DateFormat('MMM').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String dateTimeStringToDayOnly(String dateTime) {
    return DateFormat('dd').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String dateTimeStringToTimeOnly(String dateTime) {
    return DateFormat(_timeFormatter()).format(DateTime.parse(dateTime));
  }

  static String dateTimeStringToSimpleTimeOnly(String dateTime) {
    return DateFormat('hh:mm').format(DateTime.parse(dateTime));
  }

  static String twoDigits(int n) =>
      n.toString().padLeft(2, "0").replaceAll(RegExp(r'^0+(?=.)'), '');

  static String diffBetweenTime(String time1, String time2) {
    var format = DateFormat("HH:mm");
    var one = format.parse(time1);
    var two = format.parse(time2);
    int difference = two.difference(one).inMinutes;
    var duration = Duration(minutes: difference);

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    if (duration.inHours == 0) {
      return '${twoDigitMinutes}min';
    } else if (int.parse(twoDigitMinutes) == 0) {
      return '${twoDigits(duration.inHours)}h';
    } else {
      return "${twoDigits(duration.inHours)}h${twoDigitMinutes}min";
    }
  }

  static String timeAgoCustom(DateTime d) {
    // <-- Custom method Time Show  (Display Example  ==> 'Today 7:00 PM')     // WhatsApp Time Show Status Shimila
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return DateFormat.MMMEd().format(d);
    }
    if (diff.inHours > 0) {
      return "Today";
      //return "Today ${DateFormat('jm').format(d)}";
    }
    if (diff.inMinutes > 0) {
      return "Today";

      //return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "Today";
  }

  static String timeAgoCustomFr(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    String time = DateFormat('HH:mm').format(d);
    if (diff.inDays > 365) {
      final years = (diff.inDays / 365).floor();
      return "Il y a $years an${years > 1 ? 's' : ''} $time";
    }
    if (diff.inDays > 30) {
      final months = (diff.inDays / 30).floor();
      return "Il y a $months mois $time";
    }
    if (diff.inDays > 7) {
      final weeks = (diff.inDays / 7).floor();
      return "Il y a $weeks semaine${weeks > 1 ? 's' : ''} $time";
    }
    if (diff.inDays == 1) {
      return "Hier $time";
    }
    if (diff.inDays > 1) {
      return "Il y a ${diff.inDays} jours $time";
    }
    if (diff.inHours > 0) {
      return "Aujourd'hui $time";
    }
    if (diff.inMinutes > 0) {
      return "Aujourd'hui $time";
    }
    return "À l'instant";
  }

  static String formatDuration(String input) {
    Duration duration = Duration(
        milliseconds: (double.parse(input.split(':').last) * 1000).round());

    String formattedTime = "${duration.inMinutes}:${duration.inSeconds % 60}";

    return formattedTime;
  }

  static String formatTimeAgo(DateTime inputDate) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(inputDate).abs();

    if (difference.inDays < 1) {
      /* if (difference.inHours < 1) {
        if (difference.inMinutes < 1) {
          return 'just now';
        } else {
          return 'a few minutes ago';
        }
      } else {
        return 'today';
      } */
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return 'this week';
    } else if (difference.inDays < 14) {
      return 'last week';
    } else if (difference.inDays < 30) {
      return 'a few weeks ago';
    } else if (difference.inDays < 365) {
      return 'several months ago';
    } else {
      return 'a long time ago';
    }
  }

  static String dateRangeString(String startDateStr, String endDateStr,
      {bool showYear = false}) {
    final startDate = DateTime.parse(startDateStr).toUtc();
    final endDate = DateTime.parse(endDateStr).toUtc();

    final startDayFormatted = DateFormat('dd').format(startDate);
    final endDayFormatted = DateFormat('dd').format(endDate);
    final monthFormatted = DateFormat('MMM')
        .format(startDate); // Use short month name (e.g., "May")
    final yearFormatted = DateFormat('yyyy').format(startDate);
    return showYear
        ? '$startDayFormatted-$endDayFormatted $monthFormatted $yearFormatted'
        : '$startDayFormatted-$endDayFormatted $monthFormatted';
  }

  static String displayCalendarDate(DateTime date) {
    return DateFormat.yMMMMd(Get.context!.locale.languageCode).format(date);
  }

  static String convertToHourFormat(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat dateFormat =
        DateFormat.Hm(); // 'Hm' stands for hours and minutes
    return dateFormat.format(dateTime.toLocal());
  }
}
