import 'package:flutter/material.dart';

class ThemeApp {
  ThemeApp(this.context);

  final BuildContext context;

  get theme => ThemeData(
        primaryColor: Color(0xff6C63FF),
        cursorColor: Color(0xff6C63FF),
        accentColor: Color(0xff6C63FF),
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.grey[100],
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Color(0xff6C63FF),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
              color: Colors.grey[500],
              fontSize: 17.0,
            ),
          ),
          iconTheme: IconThemeData(
            color: Color(0xff6C63FF),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Color(0xff6C63FF),
          elevation: 12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.w300,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        buttonTheme: ButtonThemeData(
          minWidth: double.infinity,
          padding: EdgeInsets.only(bottom: 16, top: 16),
          buttonColor: Color(0xff6C63FF),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xff6C63FF),
        ),
      );
}
