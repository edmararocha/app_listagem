import 'package:app_listagem/src/database/databaseHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/customField.dart';
import '../models/PatientModel.dart';

enum Gender { feminino, masculino }

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Gender? _humangender = Gender.feminino;

  final dbHelper = DatabaseHelper.instance;

  final db = FirebaseFirestore.instance;

  final TextEditingController nameText = TextEditingController();
  final TextEditingController emailText = TextEditingController();
  final TextEditingController aboutText = TextEditingController();

  String gender = 'feminino';

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
                  _addPatient();
                  Navigator.of(context).pushReplacementNamed('/');

                  PatientModel patient = PatientModel();
                  patient.name = nameText.text;
                  patient.email = emailText.text;
                  patient.gender = gender;
                  patient.about = aboutText.text;

                  db.collection('patients').add(patient.toJson()).then((DocumentReference doc) =>  print('DocumentSnapshot added with ID: ${doc.id}'));
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

  _addPatient() async {
    PatientModel patient = PatientModel();
    patient.name = nameText.text;
    patient.email = emailText.text;
    patient.gender = gender;
    patient.about = aboutText.text;

    await dbHelper.insert(patient);
  }
}
