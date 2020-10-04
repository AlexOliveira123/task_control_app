import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task_control_app/app/core/entities/task_entity.dart';
import 'package:task_control_app/app/core/utils/validators.dart';
import 'package:task_control_app/app/modules/task/task_controller.dart';

class TaskDialog extends StatefulWidget {
  final scaffoldKey;
  final TaskEntity task;
  const TaskDialog({Key key, this.scaffoldKey, this.task}) : super(key: key);
  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final controller = Modular.get<TaskController>();
  final _formKey = GlobalKey<FormState>();
  final deliveryDateController = MaskedTextController(
    mask: '00/00/0000',
  );
  final conclusionDateController = MaskedTextController(
    mask: '00/00/0000',
  );

  @override
  void dispose() {
    deliveryDateController.dispose();
    controller.task = TaskEntity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.task == null ? 'Cadastrar tarefa' : 'Alterar tarefa',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue:
                    widget.task == null ? "" : widget.task.description,
                decoration: InputDecoration(
                  hintText: 'Nome',
                ),
                validator: (value) => Validators.multiValidators([
                  Validators.isRequired(value, 'Campo obrigatório'),
                  Validators.hasMinLen(
                      value, 'O nome precisa ter mais de 3 dígitos', 3)
                ]),
                onChanged: (description) =>
                    controller.setTask(description: description),
              ),
              SizedBox(height: 12),
              TextFormField(
                validator: (value) =>
                    Validators.isRequired(value, 'Campo obrigatório'),
                onChanged: (date) => controller.setTask(deliveryDate: date),
                controller: widget.task == null
                    ? deliveryDateController
                    : deliveryDateController
                  ..text = widget.task?.deliveryDate,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Data de entrega',
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                onChanged: (date) => controller.setTask(conclusionDate: date),
                controller: widget.task == null
                    ? conclusionDateController
                    : conclusionDateController
                  ..text = widget.task?.conclusionDate,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Data de conclusão',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text('Salvar'),
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              var response = widget.task == null
                  ? await controller.createTask()
                  : await controller.updateTask();

              if (response == false) {
                widget.scaffoldKey.currentState.showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(
                    "Ocorreu um erro ao salvar a tarefa. Contate o administrador.",
                  ),
                ));
              }
              Navigator.pop(context);
            }
          },
        ),
        FlatButton(
          child: Text(
            'Cancelar',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
