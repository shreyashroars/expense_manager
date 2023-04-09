import 'dart:convert';

import 'package:expense_manager/providers/trnsactionprovider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'models/transactionModel.dart';

class GetTransaction {
  List<TransactionModel> tx = [];
  Future<List<TransactionModel>> gettx() async {
    try {
      var Url = Uri.parse(
          'https://backend-for-expense-manager-dn14rlk9p-shreyashroars.vercel.app/transaction/gettx');
      var response = await http.get(Url);
      //  print(response.body);
      List<dynamic> jsonData = jsonDecode(response.body);
      //debugPrint(jsonData);
      //  print(jsonData);
      jsonData.forEach((element) {
        TransactionModel txModel = TransactionModel(
            id: element['id'],
            title: element['title'],
            amount: element['amount'],
            date: DateTime.parse(element['date']));
        tx.add(txModel);
        //  print(tx);
      });
      return tx;
    } catch (e) {
      // print('hello');
      debugPrint(e.toString());
    }
  }
}
