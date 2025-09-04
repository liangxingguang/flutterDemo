@echo off
flutter pub global activate intl_utils
flutter pub get
flutter pub run intl_utils:generate
pause