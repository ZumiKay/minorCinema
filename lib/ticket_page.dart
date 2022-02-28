import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:minor_cinemaapp/firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ticket extends StatefulWidget {
  const ticket({Key? key}) : super(key: key);

  @override
  ticketclass createState() => ticketclass();
}

class ticketclass extends State<ticket> {
  

  
  Stream<List<Tickets>> getTickets() => FirebaseFirestore.instance
      .collection('tickets')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((e) => Tickets.fromjson(e.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.black),
        alignment: Alignment.center,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Container(
                height: MediaQuery.of(context).size.height - 150,
                child: StreamBuilder<List<Tickets>>(
                  stream: getTickets(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final ticket = snapshot.data!;

                      return ListView(
                        children: ticket.map(buildTicket).toList(),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    onSurface: Colors.pinkAccent),
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
        ));
  }
}

Widget buildTicket(Tickets item) {
  return ticketContainer(
      name: item.name!,
      phonenumber: item.phonenumber!,
      id: item.id!,
      imagesrc: item.imagesrc!,
      seats: item.seats!,
      date: item.date!,
      threater: item.threater!,
      title: item.title!,
      time: item.time!,
      price: item.price!);
}

//

Widget ticketContainer(
    {String title = '',
    String value = '',
    String id = '',
    String name = '',
    String phonenumber = '',
    List<dynamic> seats = const [],
    int price = 0,
    String imagesrc = '',
    String date = '',
    String time = '',
    String threater = ''}) {
  return SizedBox(
    height: 700,
    child: Column(
      children: [
        ticketRow("ID: ", id),
        ticketRow("Name: ", name),
        ticketRow('Date:', date),
        ticketRow("Time: ", time),
        ticketRow("PhoneNumber: ", phonenumber),
        ticketRow("Movie name: ", title),
        ticketRow("Threater: ", threater),
        seatsRow(seats),
        ticketRow("Price: ", '\$${price}.00'),
        Container(
          height: 300,
          margin: const EdgeInsets.only(top: 20),
          width: double.maxFinite,
          child: Image(fit: BoxFit.contain, image: NetworkImage(imagesrc)),
        )
      ],
    ),
  );
}

Widget seatsRow(List<dynamic> seats) {
  return Row(
    children: [
      const Text(
        "Seats: ",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'font1',
            fontSize: 20,
            decoration: TextDecoration.none),
      ),
      Row(
        children: List.generate(
            seats.length,
            (index) => Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    seats[index],
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'font1',
                        fontSize: 15,
                        decoration: TextDecoration.none),
                  ),
                )),
      )
    ],
  );
}

Widget ticketRow(String title, String value) {
  return Row(
    children: [
      Text(
        title,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'font1',
            fontSize: 20,
            decoration: TextDecoration.none),
      ),
      Text(
        value,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'font1',
            fontSize: 15,
            decoration: TextDecoration.none),
      ),
    ],
  );
}
