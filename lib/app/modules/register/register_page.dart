import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task_control_app/app/core/models/address_model.dart';
import 'package:task_control_app/app/core/utils/validators.dart';
import 'register_controller.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState
    extends ModularState<RegisterPage, RegisterController> {
  var _formKey = GlobalKey<FormState>();

  var maskedTextZipcodeController = MaskedTextController(mask: '00000-000');
  var maskedTextCPFController = MaskedTextController(mask: '000.000.000-00');
  final formatDatePicker = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar uma conta')),
      body: Observer(builder: (_) {
        if (controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 12),

                  Text(
                    'Dados pessoais:',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),

                  SizedBox(height: 12),

                  TextFormField(
                    initialValue: controller.user?.name,
                    validator: (value) => Validators.multiValidators([
                      Validators.isRequired(value, 'Campo obrigatório'),
                      Validators.hasMinLen(
                          value, 'O nome deve conter no mínimo 3 dígitos', 3)
                    ]),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    onChanged: (name) => controller.setUser(name: name),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    validator: (value) => Validators.multiValidators([
                      Validators.isCPF(value, 'CPF Inválido'),
                    ]),
                    onChanged: (cpf) => controller.setUser(cpf: cpf),
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'CPF',
                    ),
                    controller: maskedTextCPFController,
                  ),

                  SizedBox(height: 16),

                  DateTimeField(
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    format: formatDatePicker,
                    validator: (value) => Validators.isRequired(
                        value.toString(), 'Campo obrigatório'),
                    decoration: InputDecoration(
                      labelText: 'Data de Nascimento',
                      helperText:
                          'Apenas usuários maiores de 12 anos podem se cadastrar.',
                      helperMaxLines: 3,
                    ),
                    onChanged: (birthday) =>
                        controller.setUser(birthday: birthday.toString()),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        locale: const Locale("pt", "PT"),
                        firstDate: DateTime(1930),
                        initialDate: currentValue ??
                            DateTime.now().subtract(Duration(days: 4383)),
                        lastDate: DateTime.now().subtract(Duration(days: 4383)),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Color(0xff6C63FF),
                              ),
                            ),
                            child: child,
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                          onChanged: (zipcode) =>
                              controller.setUser(zipcode: zipcode),
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: 'CEP',
                          ),
                          controller: maskedTextZipcodeController,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      controller.address == null
                          ? CircularProgressIndicator()
                          : Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    controller.address = AddressModel();
                                    if (controller.user.zipcode.isEmpty) {
                                      return;
                                    }

                                    AddressModel address =
                                        await controller.searchAddress();

                                    if (address?.cep == null) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Atenção'),
                                            content: Text(
                                              'CEP não encontrado/inválido.',
                                            ),
                                            actions: [
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            )
                    ],
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    // initialValue: controller.user?.email ?? '',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    onChanged: (address) =>
                        controller.setUser(address: address),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Endereço',
                      helperText: controller?.address?.logradouro != null
                          ? controller.address.addressInfo()
                          : null,
                      helperMaxLines: 3,
                    ),
                    controller: TextEditingController(
                      text: controller?.address?.logradouro != null
                          ? controller.address.addressInfo()
                          : "",
                    ),
                  ),

                  SizedBox(height: 16),

                  TextFormField(
                    initialValue: controller.user?.number != null
                        ? controller.user.number.toString()
                        : "",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    onChanged: (number) =>
                        controller.setUser(number: int.parse(number)),
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Número',
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Dados de acesso:',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),

                  SizedBox(height: 12),

                  TextFormField(
                    initialValue: controller.user?.email,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    validator: (value) => Validators.multiValidators([
                      Validators.isRequired(value, 'Campo obrigatório'),
                      Validators.isEmail(value, 'E-mail inválido')
                    ]),
                    onChanged: (email) => controller.setUser(email: email),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),

                  SizedBox(height: 16),

                  //Input password
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: controller.user?.password,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                      validator: (value) => Validators.multiValidators([
                        Validators.isRequired(value, 'Campo obrigatório'),
                        Validators.hasMinLen(value,
                            'A senha deve conter pelos menos 6 dígitos', 6),
                        Validators.hasSpecialCharacter(value,
                            'A senha deve pelo menos 1 caracter especial (Ex: @,# \$ % &).')
                      ]),
                      keyboardType: TextInputType.text,
                      onChanged: (password) =>
                          controller.setUser(password: password),
                      textCapitalization: TextCapitalization.words,
                      obscureText: controller.passwordObscure,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          child: Icon(
                            controller.passwordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[500],
                          ),
                          onTap: controller.setPasswordObscure,
                        ),
                        labelText: 'Senha',
                        helperText:
                            'A senha deve conter pelo menos 6 dígitos e ao menos 1 caracter especial (Ex: @,# \$ % &).',
                        helperMaxLines: 3,
                      ),
                    );
                  }),

                  SizedBox(height: 26),

                  //Register button
                  RaisedButton(
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var res = await controller.createUser();
                        controller.isLoading = false;

                        if (res['response']) {
                          //success message
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Sucesso'),
                                  content: Text(res['msg']),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      onPressed: () => Modular.to
                                          .pushNamedAndRemoveUntil(
                                              '/login', (route) => false),
                                    )
                                  ],
                                );
                              });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Atenção'),
                                content: Text(res['msg']),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    onPressed: () => Modular.to.pop(),
                                  )
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
