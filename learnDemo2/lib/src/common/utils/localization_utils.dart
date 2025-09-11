// 本地化工具类，提供日期和数字的本地化格式化功能

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationUtils {
  // 格式化日期
  static String formatDate(BuildContext context, DateTime dateTime, {
    String? format,
    bool useRelative = false,
  }) {
    try {
      final localizations = AppLocalizations.of(context);
      final locale = localizations?.locale ?? const Locale('en');
      final localeCode = locale.languageCode;
      
      if (useRelative) {
        // 使用相对时间（如：1小时前，2天前等）
        return _formatRelativeTime(context, dateTime);
      }
      
      // 根据语言设置不同的日期格式
      final dateFormat = format != null
          ? DateFormat(format, localeCode)
          : DateFormat.yMMMd(localeCode);
      
      return dateFormat.format(dateTime);
    } catch (e) {
      print('Failed to format date: $e');
      return dateTime.toString();
    }
  }

  // 格式化日期和时间
  static String formatDateTime(BuildContext context, DateTime dateTime) {
    try {
      final localizations = AppLocalizations.of(context);
      final locale = localizations?.locale ?? const Locale('en');
      final dateFormat = DateFormat.yMMMd(locale.languageCode)
          .addPattern(' ')
          .add_Hm();
      
      return dateFormat.format(dateTime);
    } catch (e) {
      print('Failed to format date time: $e');
      return dateTime.toString();
    }
  }

  // 格式化数字
  static String formatNumber(BuildContext context, num number, {
    int? decimalDigits,
    bool asCurrency = false,
  }) {
    try {
      final localizations = AppLocalizations.of(context);
      final locale = localizations?.locale ?? const Locale('en');
      final localeCode = locale.languageCode;
      
      NumberFormat formatter;
      
      if (asCurrency) {
        // 格式化货币
        formatter = NumberFormat.currency(
          locale: localeCode,
          decimalDigits: decimalDigits ?? 2,
        );
      } else {
        // 格式化普通数字
        formatter = NumberFormat.decimalPattern(localeCode);
        if (decimalDigits != null) {
          formatter.minimumFractionDigits = decimalDigits;
          formatter.maximumFractionDigits = decimalDigits;
        }
      }
      
      return formatter.format(number);
    } catch (e) {
      print('Failed to format number: $e');
      return number.toString();
    }
  }

  // 格式化相对时间
  static String _formatRelativeTime(BuildContext context, DateTime dateTime) {
    try {
      final localizations = AppLocalizations.of(context);
      if (localizations == null) {
        // 如果无法获取本地化实例，返回默认格式的日期时间
        return dateTime.toString();
      }
      
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      
      // 小于1分钟
      if (difference.inMinutes < 1) {
        return localizations.justNow;
      }
      
      // 小于1小时
      if (difference.inHours < 1) {
        final minutes = difference.inMinutes;
        // 在实际应用中，您应该在AppLocalizations中添加相应的复数形式方法
        // 这里为了简化，直接使用字符串拼接
        if (minutes == 1) {
          return localizations.oneMinuteAgo;
        } else {
          return '${minutes} ${localizations.minutesAgo}';
        }
      }
      
      // 小于1天
      if (difference.inDays < 1) {
        final hours = difference.inHours;
        if (hours == 1) {
          return localizations.oneHourAgo;
        } else {
          return '${hours} ${localizations.hoursAgo}';
        }
      }
      
      // 小于30天
      if (difference.inDays < 30) {
        final days = difference.inDays;
        if (days == 1) {
          return localizations.oneDayAgo;
        } else {
          return '${days} ${localizations.daysAgo}';
        }
      }
      
      // 小于1年
      if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        if (months == 1) {
          return localizations.oneMonthAgo;
        } else {
          return '${months} ${localizations.monthsAgo}';
        }
      }
      
      // 大于等于1年
      final years = (difference.inDays / 365).floor();
      if (years == 1) {
        return localizations.oneYearAgo;
      } else {
        return '${years} ${localizations.yearsAgo}';
      }
    } catch (e) {
      print('Failed to format relative time: $e');
      return dateTime.toString();
    }
  }

  // 获取当前地区的数字格式信息
  static NumberFormatSymbols getNumberFormatSymbols(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final locale = localizations?.locale ?? const Locale('en');
    return NumberFormatSymbols(locale: locale.languageCode);
  }
}