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
  List<Map<String, dynamic>> _patients = [];
  final dbHelper = DatabaseHelper.instance;
  final db = FirebaseFirestore.instance;
  bool _loading = true;

  @override
  Future<void> initState() async {
    super.initState();
    dbHelper.queryAllRows().then((list) {
      setState(() {
        _patients = list;
        _loading = false;
      });
    });
  }

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
            child: _buildPatientsList()),
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

  Widget _buildPatientsList() {
    if (_patients.isEmpty) {
      return Center(
        child: _loading
            ? const CircularProgressIndicator(
                color: Colors.deepPurple,
              )
            : const Text("Nenhum paciente cadastrado."),
      );
    } else {
      return ListView.separated(
        itemCount: _patients.length,
        itemBuilder: (BuildContext context, int index) {
          // ignore: prefer_const_constructors
          return GestureDetector(
              onTap: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePage(
                                id: _patients[index]['id'],
                                name: _patients[index]['name'],
                                email: _patients[index]['email'],
                                gender: _patients[index]['gender'],
                                about: _patients[index]['about'],
                              )),
                    )
                  },
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: PatientItem(
                  index: index,
                  patients: _patients,
                  onPressed: () {
                    _deletar(_patients[index]['id']);
                  },
                ),
              ));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }
  }

  void _deletar(int id) async {
    await dbHelper.delete(id);
    setState(() {
      dbHelper.queryAllRows().then((list) {
        setState(() {
          _patients = list;
          _loading = false;
        });
      });
    });
  }

  showAlertDialogInfo(BuildContext context) {
    // configura o button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: const Text("Ajuda"),
      content: const Text(
          '''Clique em um paciente para editá-lo ou pressione e segure para excluí-lo. '''),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  Future<Map<String, dynamic>> listar () async {
      Map<String, dynamic> list = Map<String, dynamic>();
      await db.collection("patients").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
        list = doc.data();
      }
      return list;
    });
  }
}
