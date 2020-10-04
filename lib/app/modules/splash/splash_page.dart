import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:task_control_app/app/core/enums/auth_status.dart';
import 'package:task_control_app/app/core/stores/auth/auth_store.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var disposer;
  var auth = Modular.get<AuthStore>();

  @override
  void initState() {
    super.initState();
    disposer = autorun((_) {
      Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
        if (auth.authStatus == AuthStatus.Logged) {
          Modular.to.pushReplacementNamed('/task');
        } else if (auth.authStatus == AuthStatus.Disconnected) {
          Modular.to.pushReplacementNamed('/login');
        }
      });
    });
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/img1.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
