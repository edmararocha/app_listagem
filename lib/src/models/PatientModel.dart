import 'package:flutter/cupertino.dart';

class PatientModel {
  late String name;
  late String email;
  late String gender;
  late String about;

  PatientModel({required this.name, required this.email, required this.gender, required this.about});

  PatientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['about'] = this.about;
    return data;
  }
}
