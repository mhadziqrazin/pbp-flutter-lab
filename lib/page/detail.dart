import 'package:counter_7/page/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:counter_7/model/watch_list.dart';

class MyDetailPage extends StatefulWidget {
  const MyDetailPage({
      super.key,
      required this.title,
      required this.releaseDate,
      required this.rating,
      required this.watched,
      required this.review,
    }
  );

  final String title;
  final String releaseDate;
  final String rating;
  final String watched;
  final String review;

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Watch List'),
      ),
      // Menambahkan drawer menu
      drawer: const DrawerTugas(),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(widget.title),
            Text(widget.releaseDate),
            Text(widget.rating),
            Text(widget.watched),
            Text(widget.review),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                      ),
                    ),
                  ),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}