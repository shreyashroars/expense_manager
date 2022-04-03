import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class NewTransaction extends StatelessWidget {
  //const NewTransaction({ Key? key }) : super(key: key);
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  NewTransaction(this.addTx);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              //onChanged: (value) => titleValue = value,
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              // onChanged: (value) => amountValue = value,
              controller: amountController,
            ),
            //Note: here addTx is a pointer to the function _addNewTransaction method
            //of the _UserTransaction class. This is req. bcos both the method and class
            //are private so we cannot directly access them from NewTransaction class (other class)
            //so we pass the function _addNewTransaction to the  NewTransaction class where we make
            // pointer and then pass it to a constructor and then we can use it anywhere inside
            //this class
            FlatButton(
                onPressed: () {
                  addTx(titleController.text,
                      double.parse(amountController.text));
                },
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
