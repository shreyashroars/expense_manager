import 'package:flutter/cupertino.dart';

class TransactionModel {
  String title;
  String id;
  String amount;
  DateTime date;
  TransactionModel({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
