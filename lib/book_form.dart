import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minor_cinemaapp/main.dart';

class BookForm extends StatefulWidget {
  final String imgsrc, movietitle, date, time;
  final List<String> seats;
  const BookForm({Key? key, 
  required this.imgsrc, 
  required this.movietitle, 
  required this.date, 
  required this.time, 
  required this.seats}) : super(key: key);

  @override
  BookFormPage createState() => BookFormPage();
}

class BookFormPage extends State<BookForm> {
  final form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            width: 380,
            margin: const EdgeInsets.only(left: 30),
            child: Form(
                key: form_key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.movietitle , style:const  TextStyle(fontFamily: 'font1' , fontSize: 25 , color: Colors.white , fontWeight: FontWeight.bold),),
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
                                'Threater',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'font1',
                                    fontSize: 15),
                              ),
                              Row(
                                children: List.generate(widget.seats.length, (index) => 
                                 Text(
                                widget.seats[index],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'font1',
                                    fontSize: 15),
                              )
                                ),
                              )
                             ,
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
                              ), Text(
                            "Price",
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
                    form_btn('Reserve'),
                    Container(
                      margin:const  EdgeInsets.only(top: 20),
                      child: form_btn('Cancel') ,)
                    

                  ],
                )),
          ),
        ));
  }
}

Widget inputField(TextInputType type, String label, String hint) {
  return Container(
    margin: const EdgeInsets.only(top: 20, bottom: 50),
    child: TextFormField(
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

Widget form_btn(String label) => ElevatedButton(
    onPressed: () {},
    
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
