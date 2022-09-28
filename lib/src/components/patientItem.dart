// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PatientItem extends StatelessWidget {
  final List<Map<String, dynamic>> patients;
  final int index;
  final VoidCallback onPressed;

  const PatientItem(
      {super.key,
      required this.patients,
      required this.index,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          patients[index]['_name'],
          style: const TextStyle(color: Colors.black54, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white60, elevation: 0),
          child: const Icon(
            Icons.delete,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
