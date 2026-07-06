import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NumericExtension on num {
  String toCurrency({String symbol = '\$', int decimalDigits = 2}) {
    return '$symbol${toStringAsFixed(decimalDigits)}';
  }
  
  String toCompactCurrency({String symbol = '\$'}) {
    if (abs() >= 1000000) {
      return '$symbol${(this / 1000000).toStringAsFixed(1)}M';
    } else if (abs() >= 1000) {
      return '$symbol${(this / 1000).toStringAsFixed(1)}K';
    }
    return '$symbol${toStringAsFixed(0)}';
  }
  
  String toPercentage({int decimalDigits = 1}) {
    return '${toStringAsFixed(decimalDigits)}%';
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedString({String format = 'dd/MM/yyyy'}) {
    try {
      return DateFormat(format).format(this);
    } catch (e) {
      return toString();
    }
  }
  
  String toFormattedTime() {
    return DateFormat('HH:mm').format(this);
  }
  
  String toFormattedDateTime() {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }
  
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
  
  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }
  
  bool isThisWeek() {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
    return isAfter(firstDayOfWeek) && isBefore(lastDayOfWeek);
  }
  
  bool isThisMonth() {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }
  
  bool isThisYear() {
    return year == DateTime.now().year;
  }
  
  String toRelativeString() {
    if (isToday()) {
      return 'Hoy';
    } else if (isYesterday()) {
      return 'Ayer';
    } else if (isThisWeek()) {
      final weekDays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
      return weekDays[weekday - 1];
    } else if (isThisMonth()) {
      return '$day/${month.toString().padLeft(2, '0')}';
    } else {
      return toFormattedString();
    }
  }
  
  DateTime startOfDay() {
    return DateTime(year, month, day);
  }
  
  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }
  
  DateTime startOfMonth() {
    return DateTime(year, month, 1);
  }
  
  DateTime endOfMonth() {
    return DateTime(year, month + 1, 0, 23, 59, 59, 999);
  }
  
  DateTime startOfYear() {
    return DateTime(year, 1, 1);
  }
  
  DateTime endOfYear() {
    return DateTime(year, 12, 31, 23, 59, 59, 999);
  }
}

extension StringExtension on String {
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
  
  bool isValidPassword() {
    return length >= 8;
  }
  
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  String capitalizeWords() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }
  
  String truncate({int length = 20, String ellipsis = '...'}) {
    if (this.length <= length) return this;
    return '${substring(0, length)}$ellipsis';
  }
  
  DateTime? toDateTime({String format = 'dd/MM/yyyy'}) {
    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      return null;
    }
  }
}

extension ColorExtension on String {
  Color toColor() {
    final hexString = replaceAll('#', '');
    final value = int.parse(hexString, radix: 16);
    return Color(value + 0xFF000000);
  }
}

extension ListExtension<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return firstWhere(test);
    } catch (e) {
      return null;
    }
  }
  
  bool containsWhere(bool Function(T) test) {
    try {
      firstWhere(test);
      return true;
    } catch (e) {
      return false;
    }
  }
}
