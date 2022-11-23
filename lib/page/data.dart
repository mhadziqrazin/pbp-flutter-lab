import 'package:counter_7/components/drawer.dart';
import 'package:counter_7/page/form.dart';
import 'package:flutter/material.dart';

class MyDataPage extends StatefulWidget {
  const MyDataPage({super.key});

  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Budget'),
      ),
      // Menambahkan drawer menu
      drawer: const DrawerTugas(),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: listBudget,
        ),
      )
    );
  }
}