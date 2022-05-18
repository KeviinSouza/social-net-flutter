import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:social_network_flutter/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  final String title = 'Register';
  final String titleAlert = 'Senhas incompativeis';
  final String titleContext = 'Todos os campos de senha, precisam ser iguais !';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _name = '';
  String _email = '';
  String _password = '';
  String _passwordCheck = '';

  void register() async {
    print('E-mail: $_name');
    print('E-mail: $_email');

    if (_password == _passwordCheck) {
      String api = 'https://social-network-for-class.herokuapp.com/users';

      Response response = await post(
        Uri.parse(api),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'name': _name,
          'email': _email,
          'password': _password
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        print(response.statusCode);
      }
    } else {
      print("Senhas incompativeis");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {
                      _name = text;
                    });
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Informe seu nome:',
                  ),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {
                      _email = text;
                    });
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Informe o e-mail:',
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (text) {
                    setState(() {
                      _password = text;
                    });
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Informe a senha:',
                  ),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (text) {
                    setState(() {
                      _passwordCheck = text;
                    });
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Confirme a senha:',
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextButton(
                onPressed: () {
                  register();
                },
                child: const Text('Cadastrar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
