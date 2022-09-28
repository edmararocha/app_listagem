import 'package:flutter/cupertino.dart';

class PatientModel {
  int? id;
  String? name;
  String? email;
  String? gender;
  String? about;

  PatientModel({this.id, this.name, this.email, this.gender, this.about});

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['about'] = this.about;
    return data;
  }
}