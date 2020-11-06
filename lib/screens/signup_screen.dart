import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    void _OnSuccess() {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text("Usuário criado com sucesso!"),
            backgroundColor: Theme.of(context).primaryColor,
            duration: Duration(seconds: 2)),
      );
      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.of(context).pop();
      });
    }

    void _OnFail() {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
            content: Text("Falha ao criar usuário"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2)),
      );
      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  validator: (text) {
                    if (text.isEmpty) return "Nome inválido";
                  },
                  decoration: InputDecoration(hintText: "Nome Completo"),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "E-mail inválido";
                  },
                  decoration: InputDecoration(hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido";
                  },
                  decoration: InputDecoration(hintText: "Endereço"),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passController,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha inválida";
                  },
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Senha"),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text.trim(),
                          "email": _emailController.text.trim(),
                          "address": _addressController.text.trim(),
                        };

                        model.signUp(
                            userData: userData,
                            pass: _passController.text.trim(),
                            onSuccess: _OnSuccess,
                            onFail: _OnFail);
                      }
                    },
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
