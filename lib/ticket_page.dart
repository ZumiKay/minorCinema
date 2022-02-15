import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget get ticketsPages {
  return Container(
      height: 500,
      alignment: Alignment.center,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 450,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(25)),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                ticketRow("ID: ", "1020121212"),
                ticketRow("Name: ", "Zumi"),
                ticketRow("PhoneNumber: ", "023880880"),
                ticketRow("Movie name: ", "Batment"),
                ticketRow("Seat : ", "A1"),
                ticketRow("Price: ", "3.00"),
                Container(
                  height: 220,
                  margin: const EdgeInsets.only(top: 20),
                  width: double.maxFinite,
                  child: const Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://retrology.net/wp-content/uploads/2021/10/demon.jpg'),
                  ),
                )
              ],
            ),
          )));
}

Widget ticketRow(String title, String value) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontFamily: 'font1', fontSize: 20),
      ),
      Text(
        value,
        style: const TextStyle(
            color: Colors.white, fontFamily: 'font1', fontSize: 20),
      ),
    ],
  );
}
