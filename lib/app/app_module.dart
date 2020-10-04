import 'package:dio/dio.dart';
import 'package:task_control_app/app/core/db/database.dart';
import 'package:task_control_app/app/core/services/address_service.dart';
import 'package:task_control_app/app/core/stores/auth/auth_store.dart';
import 'package:task_control_app/app/modules/splash/splash_page.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:task_control_app/app/app_widget.dart';

import 'modules/login/login_module.dart';
import 'modules/register/register_module.dart';
import 'modules/task/task_module.dart';

class AppModule extends MainModule {
  final AppDatabase db;

  AppModule(this.db);

  @override
  List<Bind> get binds => [
        $AppController,
        $AuthStore,
        Bind((i) => db),
        $AddressService,
        Bind((i) => Dio())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SplashPage()),
        ModularRouter('/login',
            module: LoginModule(), transition: TransitionType.noTransition),
        ModularRouter('/register', module: RegisterModule()),
        ModularRouter('/task', module: TaskModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
