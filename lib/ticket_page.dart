import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget ticketsPages(BuildContext context) {
  return Container(
      height: 500,
      decoration: const BoxDecoration(color: Colors.black),
      alignment: Alignment.center,
      child: 
      ListView(
        padding: const EdgeInsets.all(10),

        children: <Widget>[
          ticketContainer(),
          
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white , onPrimary: Colors.black , onSurface: Colors.pinkAccent),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Close Tickets",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decorationColor: Colors.black),
              ))
        ],
      )
      
      
      );
}
  // 

Widget ticketContainer({String title = '', String value = ''}) {
  return SizedBox(
    height: 500,
    child: Column(
      children: [
        ticketRow("ID: ", "1020121212"),
        ticketRow("Name: ", "Zumi"),
        ticketRow("PhoneNumber: ", "023880880"),
        ticketRow("Movie name: ", "Batment"),
        ticketRow("Seat : ", "A1"),
        ticketRow("Price: ", "3.00"),
        Container(
          height: 300,
          margin: const EdgeInsets.only(top: 20),
          width: double.maxFinite,
          child: const Image(
            fit: BoxFit.cover,
            image: AssetImage('images/default.jpg'),
          ),
        )
      ],
    ),
  );
}

Widget ticketRow(String title, String value) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontFamily: 'font1', fontSize: 20 , decoration: TextDecoration.none),
      ),
      Text(
        value,
        style: const TextStyle(
            color: Colors.white, fontFamily: 'font1', fontSize: 20 , decoration: TextDecoration.none),
      ),
    ],
  );
}
