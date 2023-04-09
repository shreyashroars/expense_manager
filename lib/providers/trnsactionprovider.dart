import 'package:expense_manager/models/transactionModel.dart';
import 'package:flutter/cupertino.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> tx = [];
  addtx(List<TransactionModel> txmodel) {
    tx = txmodel;
    notifyListeners();
  }
}
