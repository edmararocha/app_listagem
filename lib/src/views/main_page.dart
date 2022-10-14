import 'package:app_listagem/src/components/patientItem.dart';
import 'package:app_listagem/src/database/databaseHelper.dart';
import 'package:app_listagem/src/views/update_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final dbHelper = DatabaseHelper.instance;
  CollectionReference patientsCollection =
      FirebaseFirestore.instance.collection("patients");
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de pacientes"),
        backgroundColor: Colors.deepPurple,
        actions: [
          ElevatedButton(
            onPressed: () => {showAlertDialogInfo(context)},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, elevation: 0),
            child: const Icon(Icons.info),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: StreamBuilder(
              stream: patientsCollection.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      // ignore: prefer_const_constructors
                      return GestureDetector(
                          onTap: () => {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdatePage(patientDoc: documentSnapshot,)),
                                )
                              },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: PatientItem(
                              index: index,
                              patient: documentSnapshot,
                              onPressed: () {
                                _deletePatient(documentSnapshot.id);
                              },
                            ),
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
                } else {
                  return Center(
                    child: _loading
                        ? const CircularProgressIndicator(
                            color: Colors.deepPurple,
                          )
                        : const Text("Nenhum paciente cadastrado."),
                  );
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/add_page');
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _deletePatient(String patientId) async {
    await patientsCollection.doc(patientId).delete();
  }

  void showAlertDialogInfo(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alerta = AlertDialog(
      title: const Text("Ajuda"),
      content: const Text(
          '''Clique em um paciente para editá-lo ou no icone de lixeira para excluí-lo. '''),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}
