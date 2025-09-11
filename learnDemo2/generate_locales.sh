#!/bin/bash

# 确保中文显示正常
export LANG="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"

echo "正在激活intl_utils插件..."
flutter pub global activate intl_utils

if [ $? -ne 0 ]; then
  echo "激活intl_utils插件失败"
  exit 1
fi

echo "正在安装项目依赖..."
flutter pub get

if [ $? -ne 0 ]; then
  echo "安装项目依赖失败"
  exit 1
fi

echo "正在生成本地化代码..."
flutter pub run intl_utils:generate

if [ $? -ne 0 ]; then
  echo "生成本地化代码失败"
  exit 1
fi

echo "本地化代码生成成功！"

# 在Mac/Linux下等待用户按任意键继续
echo "按任意键继续..."
read -n 1 -s