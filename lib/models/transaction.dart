//This class is not a widget rather a  user defined data type for our transaction.
import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;
  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
