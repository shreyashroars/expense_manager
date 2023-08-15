import 'dart:io';
import 'package:expense_manager/services.dart';
import 'package:http/http.dart' as http;
import 'package:expense_manager/widgets/adaptive_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:expense_manager/secrets.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  // ignore: use_key_in_widget_constructors
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  GetTransaction gt = GetTransaction();
  var uuid = const Uuid();
  final _titleController = TextEditingController();
  DateTime selectedDate;
  final _amountController = TextEditingController();

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
  }

  postTransaction() async {
    try {
      var response =
          await http.post(Uri.parse('${Secrets.apiKey}/posttx'), body: {
        "title": _titleController.text,
        "amount": _amountController.text,
        "date": (selectedDate).toIso8601String(),
        "id": uuid.v1()
      });
      //  debugPrint(response.body);
      setState(() {
        gt.gettx();
      });

      Navigator.of(context).pop();
    } catch (e) {
      // debugPrint('nhi hua');
      print(e.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                // onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                //  onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(selectedDate == null
                        ? 'No Date Chosen'
                        : 'Chosen Date : ' +
                            DateFormat.yMd().format(selectedDate)),
                  ),
                  AdaptiveTextButton(_presentDatePicker),
                ],
              ),
              ElevatedButton(
                child: const Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    primary: Theme.of(context).primaryColor),

                //color: Theme.of(context).primaryColor,
                //textColor: Colors.white,
                onPressed: postTransaction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
