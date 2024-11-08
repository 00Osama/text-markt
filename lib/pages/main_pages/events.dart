import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  const Events({super.key});
  String getMonthName(int monthNumber) {
    if (monthNumber == 1) {
      return "January";
    } else if (monthNumber == 2) {
      return "February";
    } else if (monthNumber == 3) {
      return "March";
    } else if (monthNumber == 4) {
      return "April";
    } else if (monthNumber == 5) {
      return "May";
    } else if (monthNumber == 6) {
      return "June";
    } else if (monthNumber == 7) {
      return "July";
    } else if (monthNumber == 8) {
      return "August";
    } else if (monthNumber == 9) {
      return "September";
    } else if (monthNumber == 10) {
      return "October";
    } else if (monthNumber == 11) {
      return "November";
    } else if (monthNumber == 12) {
      return "December";
    } else {
      return "Invalid month";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String monthName = getMonthName(today.month);
    double responsiveFontSize = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F2F6),
        surfaceTintColor: const Color(0xffF2F2F6),
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  '${today.day} $monthName, ${today.year}',
                  style: TextStyle(
                    fontSize: responsiveFontSize,
                    color: const Color.fromARGB(178, 60, 60, 67),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Events',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
