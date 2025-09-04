// 应用常量定义

class AppConstants {
  // 通用常量
  static const String appName = 'Flutter MVVM + Repository Demo';
  static const String defaultAvatarUrl = 'https://picsum.photos/id/1005/200/200';
  static const String noImageUrl = 'https://via.placeholder.com/200';
  
  // 日期格式常量
  static const String dateFormatStandard = 'yyyy-MM-dd';
  static const String dateTimeFormatStandard = 'yyyy-MM-dd HH:mm:ss';
  static const String timeFormatStandard = 'HH:mm:ss';
  
  // UI常量
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 8.0;
  static const double defaultBorderRadius = 8.0;
  static const double defaultElevation = 4.0;
  static const double defaultIconSize = 24.0;
  
  // 加载状态文本
  static const String loadingText = '加载中...';
  static const String errorText = '加载失败，请重试';
  static const String emptyText = '暂无数据';
  
  // 缓存键名
  static const String cacheKeyUsers = 'users';
  static const String cacheKeyUserDetail = 'user_detail_';
  
  // 页面标题
  static const String pageTitleUserList = '用户列表';
  static const String pageTitleUserDetail = '用户详情';
  static const String pageTitleAddUser = '添加用户';
  static const String pageTitleEditUser = '编辑用户';
  static const String pageTitleProfile = '个人资料';
  static const String pageTitleSettings = '设置';
  static const String pageTitleAbout = '关于我们';
}