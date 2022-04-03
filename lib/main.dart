// ignore_for_file: deprecated_member_use

//import './models/transaction.dart';
import 'package:expense_manager/widgets/user_transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatelessWidget {
  //creating an empty list of type Transaction

  //String titleValue;
  // String amountValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: SingleChildScrollView(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: double.infinity,
                  child: const Card(
                    color: Colors.blue,
                    child: Text('Chart'),
                    elevation: 8,
                  ),
                ),
                UserTransaction(),
              ]),
        ));
  }
}
