import 'package:flutter/material.dart';

class Tickets {
  String? name, phonenumber, title, imagesrc, id, date, time, threater;
  List<dynamic>? seats;
  int? price;

  Tickets(this.name, this.phonenumber, this.title, this.price, this.imagesrc,
      this.seats, this.id, this.date);
  Tickets.fromjson(Map<String, dynamic> json) {
    name = json['Name'];
    phonenumber = json['PhoneNumber'];
    title = json['Title'];
    price = json['Price'];
    imagesrc = json['Imagesrc'];
    seats = json['Seats'];
    date = json['Date'];
    id = json['id'];
    threater = json['Threater'];
    time = json['Time'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Name'] = name;
    data['PhoneNumber'] = phonenumber;
    data['Imagesrc'] = imagesrc;
    data['Seats'] = seats;
    data['Date'] = date;
    data['Price'] = price;
    data['Threater'] = threater;
    data['Time'] = time;
    return data;
  }
}
