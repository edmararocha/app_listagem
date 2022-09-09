import 'package:flutter/material.dart';

import '../components/customField.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

	int? _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Paciente"),
        backgroundColor: Colors.deepPurple,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 50.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const CustomField(labelText: 'Nome'),
              const SizedBox(
                height: 40,
              ),
              const CustomField(labelText: "Email"),
              const SizedBox(
                height: 60,
              ),
              // Row(
              //   children: <Widget>[
              //     for (int i = 1; i <= 2; i++)
              //       ListTile(
              //         title: Text(
              //           'Radio $i',
              //           style: Theme.of(context).textTheme.subtitle1?.copyWith(
              //               color: i == 5 ? Colors.black38 : Colors.black),
              //         ),
              //         leading: Radio(
              //           value: i,
              //           groupValue: _value,
              //           activeColor: Color(0xFF6200EE),
              //           onChanged: (value) => {
							// 						setState(() {
							// 							_value = value as int?;
							// 						})
							// 					},
              //         ),
              //       ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
