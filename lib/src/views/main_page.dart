import 'package:app_listagem/src/database/databaseHelper.dart';
import 'package:app_listagem/src/views/update_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, dynamic>> _patients = [];
  final dbHelper = DatabaseHelper.instance;
  bool _loading = true;

  @override
  void initState() {
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
                                id: _patients[index]['_id'],
                                name: _patients[index]['_name'],
                                email: _patients[index]['email'],
                                gender: _patients[index]['gender'],
                                about: _patients[index]['about'],
                              )),
                    )
                  },
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _patients[index]['_name'],
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _deletar(_patients[index]['_id']);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white60, elevation: 0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }
  }

  void _deletar(int id) async {
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
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Ajuda"),
      content: Text(
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
}
