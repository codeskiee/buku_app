import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Profile.dart';
import '../model/cadastro.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _nomeController;
  late TextEditingController _senhaController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nomeController = TextEditingController();
    _senhaController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(""),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.height / 2.3,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 25.0,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  controller: _nomeController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  decoration: InputDecoration(
                                    labelText: "Masukkan Username",
                                    labelStyle:
                                        TextStyle(color: Colors.blueAccent),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "Username masih kosong";
                                    }
                                    if (value.length < 3) {
                                      return "minimal 3 karakter";
                                    }
                                    return null;
                                  },
                                ),
                                Divider(),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  decoration: InputDecoration(
                                    labelText: "Masukkan e-mail",
                                    labelStyle:
                                        TextStyle(color: Colors.blueAccent),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "email masih kosong";
                                    }
                                    if (value.length < 10 ||
                                        !value.contains("@")) {
                                      return "email tidak valid";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: _senhaController,
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  decoration: InputDecoration(
                                    labelText: "Masukkan Password",
                                    labelStyle:
                                        TextStyle(color: Colors.blueAccent),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "password masih kosong";
                                    }
                                    if (value.length < 6) {
                                      return "masukkan beberapa karakter";
                                    }
                                    return null;
                                  },
                                ),
                                Divider(),
                                ElevatedButton(
                                  onPressed: buttonCadastroClicado,
                                  child: Text(
                                    "Daftar",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.lightBlue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 7,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 25.0,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Image(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.height / 5,
                          image: AssetImage('lib/assets/profil.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buttonCadastroClicado() {
    if (_formKey.currentState!.validate()) {
      Cad nome = Cad.withData(
        nome: _nomeController.text,
        email: _emailController.text,
        senha: _senhaController.text,
      );
      BlocProvider.of<ProfileBloc>(context).add(SubmitEvent(nome: nome));
      print("Form tidak valid!");
      // Exibe o dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Berhasil"),
            content: Text("Pendaftaran Berhasil dilakukan"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o dialog
                  Navigator.pushNamed(
                      context, '/login'); // Vai para a tela de login
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      // Pega os dados
      print(
          "${_emailController.text}, ${_nomeController.text}, ${_senhaController.text}");
    } else {
      print("Formulário inválido!");
    }
  }
}
