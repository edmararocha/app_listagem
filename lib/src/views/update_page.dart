import 'package:flutter/material.dart';

import '../components/customField.dart';
import '../database/databaseHelper.dart';

enum Gender { feminino, masculino }

class UpdatePage extends StatefulWidget {
  const UpdatePage(
      {super.key, this.id, this.name, this.email, this.gender, this.about});

  final int? id;
  final String? name;
  final String? email;
  final String? gender;
  final String? about;

  @override
  State<UpdatePage> createState() =>
    _UpdatePageState(id, name, email, gender, about);
}

class _UpdatePageState extends State<UpdatePage> {
  Gender? _humangender = Gender.feminino;

  final dbHelper = DatabaseHelper.instance;

  final TextEditingController nameText = TextEditingController();
  final TextEditingController emailText = TextEditingController();
  final TextEditingController aboutText = TextEditingController();

  final int? id;
  final String? name;
  final String? email;
  String? gender;
  final String? about;

  _UpdatePageState(this.id, this.name, this.email, this.gender, this.about);

  @override
  void initState() {
    _verifyGender();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () => {Navigator.pushReplacementNamed(context, '/')},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple, elevation: 0),
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text("Adicionar Paciente"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 25.0, left: 25.0, top: 50.0),
          child: Column(
            children: [
              CustomField(
                  labelText: 'Nome',
                  type: TextInputType.name,
                  controller: nameText),
              const SizedBox(
                height: 40,
              ),
              CustomField(
                labelText: "Email",
                type: TextInputType.emailAddress,
                controller: emailText,
              ),
              const SizedBox(
                height: 40,
              ),
              Column(children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Sexo",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.deepPurple,
                        fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Colors.deepPurple,
                              value: Gender.feminino,
                              groupValue: _humangender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _humangender = value;
                                  gender = 'feminino';
                                });
                              }),
                          const Expanded(
                            child: Text('Feminino'),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Radio(
                              activeColor: Colors.deepPurple,
                              value: Gender.masculino,
                              groupValue: _humangender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _humangender = value;
                                  gender = 'masculino';
                                });
                              }),
                          const Expanded(
                            child: Text('Masculino'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
              const SizedBox(
                height: 50,
              ),
              CustomField(
                labelText: "Sobre",
                type: TextInputType.text,
                controller: aboutText,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  _updatePatient();
                  Navigator.of(context).pushReplacementNamed('/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Adicionar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _updatePatient() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: this.id,
      DatabaseHelper.columnName: nameText.text,
      DatabaseHelper.columnEmail: emailText.text,
      DatabaseHelper.columnGender: gender,
      DatabaseHelper.columnAbout: aboutText.text
    };
    final id = await dbHelper.update(row);
    print('linha inserida id: $id');
  }

  _verifyGender() {
    print("GENDER: $gender");
    if (gender == 'feminino') {
      _humangender = Gender.feminino;
    } else {
      _humangender = Gender.masculino;
    }
  }
}
