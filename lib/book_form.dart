import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minor_cinemaapp/main.dart';

class BookForm extends StatefulWidget {
  const BookForm({Key? key}) : super(key: key);

  @override
  BookFormPage createState() => BookFormPage();
}

class BookFormPage extends State<BookForm> {
  final form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: 380,
          margin: const EdgeInsets.only(left: 30),
          child: Form(
              key: form_key,
              child: Column(
                children: <Widget>[
                  inputField(
                      TextInputType.emailAddress, 'Email', 'ex@example.com'),
                  inputField(TextInputType.name, 'Name', "John"),
                  inputField(TextInputType.phone, 'PhoneNumber', '023880880'),
                  inputField(TextInputType.text, 'Remark', 'optional'),
                  form_btn('Reserve')
                ],
              )),
        ));
  }
}

Widget inputField(TextInputType type, String label, String hint) {
  return Container(
    margin: const EdgeInsets.only(top: 20 , bottom: 50),
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

Widget form_btn(String label) => ElevatedButton(onPressed: () {},
 child: Text(label.toUpperCase() , style: const TextStyle(fontFamily: 'font1' , fontSize: 15),),
 style: ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10),
       side: const BorderSide(color: Colors.grey)
       
     )
   )
   
 )

);
