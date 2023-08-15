import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionItem1 extends StatelessWidget {
  String title, amount;
  DateTime date;
  TransactionItem1({this.amount, this.date, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.98,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            // color: Color.fromARGB(255, 233, 159, 247),
            //color: Color.fromARGB(255, 238, 198, 245),
            color: Color.fromARGB(255, 255, 222, 124),
            borderRadius: BorderRadius.circular(20),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 80,
              child: Text(
                '₹' + " " + amount,
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 120, 11, 3),
                    textStyle: TextStyle(fontWeight: FontWeight.w500)),
              ),
            ),
            Container(
              width: 120,
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat.yMMMd().format(date),
                style: GoogleFonts.poppins(
                    color: Colors.blue,
                    textStyle: TextStyle(fontWeight: FontWeight.w500)),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
