import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minor_cinemaapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class BookForm extends StatefulWidget {
  final String imgsrc, movietitle, date, time, threater;
  final List<String> seats;
  final int price;

  const BookForm(
      {Key? key,
      required this.threater,
      required this.imgsrc,
      required this.movietitle,
      required this.date,
      required this.time,
      required this.seats,
      required this.price})
      : super(key: key);

  @override
  BookFormPage createState() => BookFormPage();
}

class BookFormPage extends State<BookForm> {
  final form_key = GlobalKey<FormState>();
  String id = '';
  var uuid = const Uuid();

  Map<String, String> formdata = {};
  Future<void> setiD() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var uniqueID = uuid.v4();

    if (pref.getString(widget.movietitle) != null) {
      pref.setString('${widget.movietitle}$uniqueID', uniqueID);
      id = uniqueID;
    } else {
      pref.setString('${widget.movietitle}$uniqueID', uniqueID);
      id = uniqueID;
    }
  }

  @override
  void initState() {
    super.initState();
    setiD();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference db = FirebaseFirestore.instance.collection('tickets');
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            width: 380,
            
            child: Form(
                key: form_key,
                child: ListView(
                  
                  children: <Widget>[
                    Text(
                      widget.movietitle,
                      style: const TextStyle(
                          fontFamily: 'font1',
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    inputField(
                        TextInputType.emailAddress, 'Email', 'ex@example.com'),
                    inputField(TextInputType.name, 'Name', "John"),
                    inputField(TextInputType.phone, 'PhoneNumber', '023880880'),
                    inputField(TextInputType.text, 'Remark', 'optional'),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                              width: 150,
                              height: 300,
                              image: NetworkImage(widget.imgsrc)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.threater,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'font1',
                                    fontSize: 15),
                              ),
                              Row(
                                children: List.generate(
                                    widget.seats.length,
                                    (index) => Text(
                                          widget.seats[index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'font1',
                                              fontSize: 15),
                                        )),
                              ),
                              Text(
                                widget.time,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'font1',
                                    fontSize: 15),
                              ),
                              Text(
                                widget.date,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'font1',
                                    fontSize: 15),
                              ),
                              Text(
                                '\$${widget.price}.00',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'font1',
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    form_btn('Reserve', context, db),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: form_btn('Cancel', context, db),
                    )
                  ],
                )),
          ),
        ));
  }

  Widget inputField(TextInputType type, String label, String hint) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 50),
      child: TextFormField(
        onChanged: (data) {
          setState(() {
            formdata[label] = data;
          });
        },
        keyboardType: type,
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.black, fontFamily: 'font1'),
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            fillColor: Colors.white,
            filled: true,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0))),
      ),
    );
  }

  Widget form_btn(String label, BuildContext context, CollectionReference db) {
    Future<void> addTickets() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return db.add({
        'id': pref.getString('${widget.movietitle}$id'),
        'Email': formdata['Email'],
        'Name': formdata['Name'],
        'PhoneNumber': formdata['PhoneNumber'],
        'Threater': widget.threater,
        'Seats': widget.seats,
        'Date': widget.date,
        'Time': widget.time,
        'Title': widget.movietitle,
        'Price': widget.price,
        'Imagesrc': widget.imgsrc,
        'Remark': formdata['Remark'] ?? 'Optional'
      }).then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) =>const Minor() ), (route) => false);
      }).catchError((error) => print(error));
    }

    return ElevatedButton(
        onPressed: () {
          if (label == 'Cancel') {
            Navigator.pop(context);
          } else {
            if (formdata.isNotEmpty) {
              addTickets();
            }
          }
        },
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(fontFamily: 'font1', fontSize: 15),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.grey)))));
  }
}
