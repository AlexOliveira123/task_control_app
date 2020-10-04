import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_control_app/app/core/entities/task_entity.dart';
import 'package:task_control_app/app/modules/task/components/task_dialog.dart';
import 'package:task_control_app/app/modules/task/task_controller.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  const TaskItem({
    Key key,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<TaskController>();
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(task.description),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data de entrega:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(task?.deliveryDate ?? ""),
                  SizedBox(height: 12),
                  Text(
                    'Data de conclusão:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(task?.conclusionDate ?? ""),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              task?.description ?? "",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                task.status == "Finished"
                    ? Container()
                    : IconButton(
                        icon: Icon(
                          FontAwesomeIcons.check,
                          color: Colors.greenAccent,
                        ),
                        onPressed: () {
                          showDialog(
                            context: (context),
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Atenção'),
                                content: Text(
                                  'Deseja realmente finalizar esta tarefa?',
                                ),
                                actions: [
                                  FlatButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () async {
                                      controller.task =
                                          task.copyWith(status: "Finished");
                                      await controller.updateTask();
                                      Navigator.pop(context);
                                    },
                                    child: Text('Sim'),
                                  ),
                                  FlatButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Não',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                task.status == "Finished"
                    ? Container()
                    : IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.orangeAccent,
                        ),
                        onPressed: () {
                          controller.task = task;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return TaskDialog(task: task);
                            },
                          );
                        },
                      ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    showDialog(
                      context: (context),
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Atenção'),
                          content:
                              Text('Deseja realmente excluir esta tarefa?'),
                          actions: [
                            FlatButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                await controller.deleteTask(task);
                                Navigator.pop(context);
                              },
                              child: Text('Sim'),
                            ),
                            FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Não',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
