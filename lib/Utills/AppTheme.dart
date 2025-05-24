import '/Constants/AppColors.dart';
import 'package:flutter/material.dart';

enum AppTheme {dark, light}

Map<AppTheme, ThemeData> kMyAppTheme = {
  AppTheme.dark : ThemeData(
    primaryColor: Colors.grey.shade900,
    scaffoldBackgroundColor: Colors.grey.shade900,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white
      )
    )
  ),
  AppTheme.light : ThemeData(
      primaryColor: AppColors.primaryColor,
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: Colors.black
          )
      )
  )
};