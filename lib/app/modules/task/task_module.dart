import 'task_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'task_page.dart';

class TaskModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $TaskController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => TaskPage()),
      ];

  static Inject get to => Inject<TaskModule>.of();
}
