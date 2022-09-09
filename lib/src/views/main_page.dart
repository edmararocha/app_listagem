import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> lista = ["Pedro", "Paulo", "José", "Maria", "Socorro", "Joana"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de pacientes"),
        backgroundColor: Colors.deepPurple,
        actions: [
          ElevatedButton(
            onPressed: () => {},
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
          child: ListView.separated(
            itemCount: lista.length,
            itemBuilder: (BuildContext context, int index) {
              // ignore: prefer_const_constructors
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lista[index],
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white60, elevation: 0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/add_page");
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
