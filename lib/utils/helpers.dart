import 'package:flutter/material.dart';

  bool isSameDay(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day;
  }

  bool isSameWeek(DateTime dateTime1, DateTime dateTime2) {
    // Verifica se ambos os DateTime estão na mesma semana e ano
    return dateTime1.year == dateTime2.year &&
        dateTime1.weekday == dateTime2.weekday &&
        dateTime1.difference(dateTime2).inDays.abs() < 7;
  }

  bool isSameBiWeek(DateTime dateTime1, DateTime dateTime2) {
    // Verifica se ambos os DateTime estão na mesma semana e ano
    return dateTime1.year == dateTime2.year &&
        dateTime1.weekday == dateTime2.weekday &&
        dateTime1.difference(dateTime2).inDays.abs() < 14;
  }

  bool isSameMonth(DateTime dateTime1, DateTime dateTime2) {
    // Verifica se ambos os DateTime estão no mesmo mês e ano
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month;
  }

  bool isSameQuarter(DateTime dateTime1, DateTime dateTime2) {
  // Calculate the quarter for each DateTime object
  int getQuarter(DateTime dateTime) {
    return ((dateTime.month - 1) / 3).floor() + 1;
  }

  // Check if both DateTime objects are in the same year and quarter
  return dateTime1.year == dateTime2.year &&
      getQuarter(dateTime1) == getQuarter(dateTime2);
}

  bool isSameYear(DateTime dateTime1, DateTime dateTime2) {
    // Verifica se ambos os DateTime estão no mesmo ano
    return dateTime1.year == dateTime2.year;
  }


class Helper {


  static closeKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  double calculatePercentage(double currentAmount, double targetAmount) {
  if (targetAmount == 0) {
    // Handle division by zero scenario
    return 0.0;
  }

  double percentage = currentAmount / targetAmount;

  // Ensure the percentage is within the range of 0 to 1
  if (percentage > 1.0) {
    return 1.0; // Cap the percentage at 1 if current amount exceeds the target
  } else if (percentage < 0.0) {
    return 0.0; // Set the percentage to 0 if current amount is negative
  } else {
    return percentage;
  }
}

} 