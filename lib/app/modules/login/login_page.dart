import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task_control_app/app/core/utils/validators.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Logo
                Image.asset(
                  'assets/images/img4.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                ),

                SizedBox(height: 15),

                //Animation with the forms
                _animation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _animation() {
    return Observer(builder: (_) {
      //Animation on login
      return AnimatedCrossFade(
        firstChild: _firstChild(), // Form login
        secondChild: _secondChild(), // Loader
        crossFadeState: controller.isLoading
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 500),
      );
    });
  }

  // login form
  Widget _firstChild() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: <Widget>[
            //Input e-mail
            TextFormField(
              validator: (value) => Validators.multiValidators([
                Validators.isRequired(value, 'Campo obrigatório'),
                Validators.isEmail(value, 'E-mail inválido'),
              ]),
              onChanged: controller.onChangedEmail,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w300,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: Color(0xff6C63FF),
                ),
                labelText: 'E-mail',
              ),
            ),

            SizedBox(
              height: 10,
            ),

            //Input password
            Observer(builder: (_) {
              return TextFormField(
                validator: (value) =>
                    Validators.isRequired(value, 'Campo obrigatório'),
                onChanged: controller.onChangedPassword,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w300,
                ),
                obscureText: controller.obscurePassword,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xff6C63FF),
                  ),
                  suffixIcon: InkWell(
                    child: Icon(
                      controller.obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey[500],
                    ),
                    onTap: controller.setObscurePassword,
                  ),
                  labelText: 'Senha',
                ),
              );
            }),

            SizedBox(
              height: 30,
            ),

            //Button to access the app
            // with credentials
            RaisedButton(
              child: Text(
                'Acessar',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                if (_formKey.currentState.validate()) {
                  var res = await controller.logIn();
                  controller.isLoading = false;

                  if (res == null) {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(
                        "Não foi possível realizar o login. Usuário não encontrado.",
                      ),
                    ));
                  } else {
                    Modular.to.pushReplacementNamed('/task');
                  }
                }
              },
            ),

            SizedBox(height: 10),

            //Create account text
            RichText(
              text: TextSpan(
                text: "Ainda não é registrado? ",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: "Crie sua conta!",
                    style: TextStyle(
                      color: Color(0xff6C63FF),
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Modular.to.pushNamed('/register'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //loader
  Widget _secondChild() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: SizedBox(
          width: 72,
          height: 72,
          child: CircularProgressIndicator(
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }
}
