// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quiz/home.dart';
import 'package:quiz/main.dart';

class Result extends StatefulWidget {
  final List answers;
  const Result({
    Key? key,
    required this.answers,
  }) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    int j = 0;
    int k = widget.answers.length - 1;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.purpleAccent])),
        child: ListView.builder(
            itemCount: widget.answers.length,
            itemBuilder: (c, i) {
              if (widget.answers[i] == 'true') {
                j++;
                return ListTile(
                  title: Text("True"),
                  trailing: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      Icons.done,
                      color: Colors.green,
                      weight: 30,
                      size: 35,
                    ),
                  ),
                );
              } else if (widget.answers[i] == 'end') {
                return Center(
                  child: Text('Result = ${j}/${k}'),
                );
              } else
                return ListTile(
                  title: Text('False'),
                  subtitle: Text(widget.answers[i]),
                  trailing: Icon(
                    Icons.close,
                    color: Colors.red,
                    weight: 30,
                    size: 35,
                  ),
                );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: TextButton.icon(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (c) => Home()));
            },
            label: Text('Try Again'),
            icon: Icon(Icons.add),
          )),
    );
  }
}
