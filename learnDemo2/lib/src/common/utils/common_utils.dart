// 通用工具函数

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../constants/app_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../extensions/context_extensions.dart';

class CommonUtils {
  // 显示加载对话框
  static Future<void> showLoadingDialog(BuildContext context, {
    String message = AppConstants.loadingText,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16.0),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  // 显示消息提示
  static void showSnackbar(BuildContext context, String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? Colors.grey[700],
        duration: duration,
      ),
    );
  }

  // 显示确认对话框
  static Future<bool> showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(context.localizations.buttonCancel),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(context.localizations.buttonConfirm),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  // 获取本地缓存目录
  static Future<Directory> getCacheDirectory() async {
    final directory = await getTemporaryDirectory();
    final cacheDir = Directory('${directory.path}/${AppConstants.cacheDir}');
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir;
  }

  // 验证邮箱格式
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // 防抖函数
  static Function debounce(Function func, Duration delay) {
    Timer? timer;
    return () {
      if (timer?.isActive ?? false) {
        timer?.cancel();
      }
      timer = Timer(delay, () => func());
    };
  }

  // 节流函数
  static Function throttle(Function func, Duration delay) {
    bool isThrottled = false;
    return () {
      if (!isThrottled) {
        isThrottled = true;
        func();
        Future.delayed(delay, () => isThrottled = false);
      }
    };
  }
}