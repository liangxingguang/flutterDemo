// String扩展方法

extension StringExtensions on String {
  // 检查字符串是否为空或只包含空白字符
  bool isEmptyOrWhitespace() {
    return trim().isEmpty;
  }

  // 检查字符串是否为有效的邮箱地址
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }

  // 检查字符串是否为有效的手机号（中国大陆）
  bool isValidPhoneNumber() {
    final phoneRegex = RegExp(r'^1[3-9]\d{9}$');
    return phoneRegex.hasMatch(this);
  }

  // 首字母大写
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  // 所有单词首字母大写
  String capitalizeAll() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  // 转换为安全的URL
  String toSafeUrl() {
    return replaceAll(' ', '%20');
  }

  // 隐藏敏感信息（如手机号、邮箱）
  String maskSensitiveInfo() {
    if (isEmpty) return this;
    if (this.length <= 6) {
      return '*' * this.length;
    }
    final visibleLength = this.length ~/ 4;
    final maskedLength = this.length - visibleLength * 2;
    return this.substring(0, visibleLength) + 
           '*' * maskedLength + 
           this.substring(visibleLength + maskedLength);
  }
}

// DateTime扩展方法

extension DateTimeExtensions on DateTime {
  // 格式化日期为标准格式
  String toStandardFormat() {
    return '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  // 格式化日期时间为标准格式
  String toDateTimeFormat() {
    return '${toStandardFormat()} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
  }

  // 检查是否是今天
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  // 检查是否是昨天
  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  // 检查是否是明天
  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  // 检查是否是今年
  bool isThisYear() {
    return year == DateTime.now().year;
  }
}