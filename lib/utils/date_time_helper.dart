import 'dart:developer';

import 'package:intl/intl.dart';

import '../core/providers/date_state.dart';
import '../features/3d/models/three_d_section.dart';

String formatDate(String dateString) {
  return DateFormat("dd-MM-yyyy hh:mm").format(
    DateTime.parse(dateString).toLocal(),
  );
}

/// please add (hh:mm:ss) format param,
/// to convert (12:00 AM) or (12:00 PM) format
String formatTime(String hhmmss) {
  final list = hhmmss.split(":");
  final hour = int.parse(list.first);
  final minute = list[1];
  final format = hour < 12 ? "AM" : "PM";
  final formatedHour = hour > 12 ? hour % 12 : hour;
  final hr =
      formatedHour.toString().length < 2 ? "0$formatedHour" : "$formatedHour";

  final section = "$hr:$minute $format";
  return section;
}

bool isThreeDClose(ThreeDSection section) {
  final closelist = section.close?.split(" ").first.split(":") ?? [];
  //this one format current time to hr:m:s
  final nowlist =
      DateFormat.jms().format(DateTime.now()).split(" ").first.split(":");
  int closeSec = 0;
  int nowSec = 0;

  if (int.parse(section.date3d!) != DateTime.now().day) {
    return false;
  }

  //comming string 12:00 PM
  for (int i = 0; i < closelist.length; i++) {
    if (i == 0) {
      //for hour
      final h = int.parse(closelist[i]);
      final isPm = section.close!.split(" ").last == "PM";
      final hour = isPm ? (h == 12 ? h : (h + 12)) : h;
      closeSec += hour * 3600;
    } else if (i == 1) {
      //for minute
      closeSec += int.parse(closelist[i]) * 60;
    } else {
      //for sec
      closeSec += int.parse(closelist[i]);
    }
  }
  for (int i = 0; i < nowlist.length; i++) {
    if (i == 0) {
      nowSec += int.parse(nowlist[i]) * 3600;
    } else if (i == 1) {
      nowSec += int.parse(nowlist[i]) * 60;
    } else {
      nowSec += int.parse(nowlist[i]);
    }
  }
  if (nowSec >= closeSec) {
    log("3 section closed");
    return true;
  } else {
    return false;
  }
}

/// please add (hh:mm:ss) format param,
///to check current section is expired or not
bool isExpired({required String closeTime}) {
  final now = DateTime.now();
  final todayDate =
      "${now.year}-${now.month.toString().length == 1 ? '0${now.month}' : now.month}-${now.day.toString().length == 1 ? '0${now.day}' : now.day}";
  final hh = "${now.hour.toString().length == 1 ? '0${now.hour}' : now.hour}";
  final mm =
      "${now.minute.toString().length == 1 ? '0${now.minute}' : now.minute}";
  final ss =
      "${now.second.toString().length == 1 ? '0${now.second}' : now.second}";
  final todayHHMMSS = "$hh:$mm:$ss";
  final isExpired = DateTime.parse('$todayDate $todayHHMMSS')
      .isAfter(DateTime.parse('$todayDate $closeTime'));
  if (isExpired) {
    return true;
  } else {
    return false;
  }
}

DateFormat df = DateFormat('yyyy-MM-d');
String startDateAll = df.format(DateTime(2021, 01, 01));
String today = df.format(
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
String yesterday = df.format(DateTime.now().subtract(const Duration(days: 1)));
String startDateMonth =
    df.format(DateTime(DateTime.now().year, DateTime.now().month, 1));

String startDateLastMonth =
    df.format(DateTime(DateTime.now().year, DateTime.now().month - 1, 1));
String endDateLastMonth =
    df.format(DateTime(DateTime.now().year, DateTime.now().month, 0));

String formatDateForRange(DateTime date) => df.format(date);

gFormatTimeToLocalDate(String str) {
  DateTime parseDate = DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(str, true);
  DateTime date = parseDate.toLocal();

  final result = DateFormat("dd-MM-yyyy").format(date);

  return result;
}

bool isOver15Days(String date) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime today = DateTime.now();
  DateTime parseDate = dateFormat.parse(date);
  final dayDif = today.difference(parseDate).inDays;
  if (dayDif >= 15) {
    return true;
  } else {
    return false;
  }
}

String formatDateForOnlyDay(String fulldate, String day) {
  final list = fulldate.split("-");
  final year = list.first;
  final month = list[1];
  return "$year-$month-$day";
}

/// from 2022-11-30 09:16:29 to Web,June 20
String dateFormatForThai2DLive(String date) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  DateTime parseDate = dateFormat.parse(date);
  return DateFormat.MMMEd().format(parseDate);
}

String currentDateTimeForThai2DLive() {
  return DateFormat.MMMEd().format(DateTime.now());
}

/// from 2022-11-30 09:16:29 to 12:03:11 PM
String currentTimeForThaiLive(String date) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  DateTime parseDate = dateFormat.parse(date);
  return DateFormat.jms().format(parseDate);
}

List<DateState> dateList = [
  DateState(startDate: today, endDate: today, title: "Today"),
  DateState(startDate: yesterday, endDate: yesterday, title: "Yesterday"),
  DateState(startDate: startDateMonth, endDate: today, title: "This month"),
  DateState(
    startDate: startDateLastMonth,
    endDate: endDateLastMonth,
    title: "Last month",
  ),
  DateState(startDate: startDateAll, endDate: today, title: "All"),
  const DateState(startDate: "", endDate: "", title: "Period"),
];
