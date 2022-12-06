import 'package:expenses/uteis/widgts/botao.dart';
import 'package:flutter/material.dart';
import 'package:expenses/uteis/widgts/CampoTextFormField.dart';

import 'controls/control_login_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ControlLoginScreen _control;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _control = ControlLoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: _body(),
    );
  }

  _body(){
    return Form(
      key: _control.formkey,
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            CampoTextFormField(
              "Login",
              texto_dica: "Digite o Login",
              controlador: _control.control_login,
              teclado: TextInputType.emailAddress,
              recebedor_foco: _control.focus_password,
            ),
            SizedBox(
              height: 10,
            ),
            CampoTextFormField(
              "Senha",
              texto_dica: "Digite a senha",
              passaword: true,
              validador: (String? text){
                if(text!.isEmpty)
                  return "O campo $text está vazio";
                else if(text.length<6)
                  return "A senha precisa ter no minimo 6 caracteres";
                return null;
              },
              controlador: _control.control_password,
              marcador_foco: _control.focus_password,
              recebedor_foco: _control.focos_buton,
            ),
            SizedBox(
              height: 10,
            ),
            Botao(
              texto: "Login",
              cor: Colors.green,
              ao_clicar: (){
                _control.login(context);
              },
              marcador_foco: _control.focos_buton,
            ),
          ],
        ),
      ),
    );
  }


}