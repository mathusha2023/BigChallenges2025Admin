import 'package:bc_admin/data/doctor_list_model.dart';
import 'package:flutter/material.dart';

class DoctorInfoPage extends StatefulWidget {
  const DoctorInfoPage({super.key, required this.doctor});

  final DoctorListModel doctor;

  @override
  State<DoctorInfoPage> createState() => _DoctorInfoPageState();
}

class _DoctorInfoPageState extends State<DoctorInfoPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
