import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minor_cinemaapp/Bloc/cinema_bloc.dart';
import 'package:minor_cinemaapp/book_form.dart';
import 'package:minor_cinemaapp/chairmodel.dart';
import 'package:minor_cinemaapp/main.dart';
import 'package:minor_cinemaapp/seats.dart';

class Chair extends StatefulWidget {
  final String movietitle;
  final String date;
  final String time;
  final String imgsrc;

  const Chair(
      {Key? key,
      required this.movietitle,
      required this.imgsrc,
      required this.date,
      required this.time})
      : super(key: key);

  @override
  Chairselection createState() => Chairselection();
}

class Chairselection extends State<Chair> {
  Map<int, bool> clickState = {};
  Map<String, int> seats = {};
  FToast ftoast = FToast();
  @override
  void initState() {
    super.initState();
    clickState[-1] = false;
    ftoast = FToast();
    ftoast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final cinemaBloc = BlocProvider.of<CinemaBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movietitle,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'font1',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: chairbody(cinemaBloc),
    );
  }

  Widget chairbody(CinemaBloc cinemaBloc) {
    return Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: double.maxFinite,
              child: Column(
                children: [
                  Text(
                    widget.date,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.time,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "ENG",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              height: 530,
              decoration: const BoxDecoration(color: Colors.grey),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(color: Colors.black38),
                    child: const Text(
                      "SCREEN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    height: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 400, width: 50, child: chairletter),
                        SizedBox(
                          height: 400,
                          width: 400,
                          child: Column(
                            children: List.generate(
                                Chairs.listChair.length,
                                (index) => SeatRow(
                                    numSeats: Chairs.listChair[index].seats,
                                    freeSeats:
                                        Chairs.listChair[index].freeseats,
                                    rowSeats:
                                        Chairs.listChair[index].rowSeats)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 200),
                          child: Row(
                            children: [
                              Column(
                                children: const <Widget>[
                                  Image(
                                    image: AssetImage('images/chair.png'),
                                    width: 30,
                                    height: 30,
                                  ),
                                  Text(
                                    'Avialable',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                              Column(
                                children: const <Widget>[
                                  Image(
                                    image: AssetImage('images/chair2.png'),
                                    width: 30,
                                    height: 30,
                                  ),
                                  Text(
                                    'Unavialable',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          )),
                      const Image(
                        image: AssetImage('images/chair.png'),
                        width: 30,
                        height: 30,
                      ),
                      const Text(
                        "\$3.00",
                        style: TextStyle(
                            fontFamily: 'font1', fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              decoration: const BoxDecoration(color: Colors.grey),
              height: 200,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    heightFactor: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Text(
                          'Seats',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'font1',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 100,
                          height: 30,
                          child: BlocBuilder<CinemaBloc, CinemaState>(
                            builder: (context, state) {
                              return Row(
                                children: List.generate(
                                    state.selectedSeats.length,
                                    (index) => Text(
                                          state.selectedSeats[index],
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontFamily: 'font1',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const Expanded(
                      child: Divider(
                    color: Colors.white,
                    thickness: 3,
                  )),
                  BlocBuilder<CinemaBloc, CinemaState>(
                    builder: (context, state) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Total: \$${state.selectedSeats.length * 3}.00",
                            style: const TextStyle(
                                fontFamily: 'font1',
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black, onSurface: Colors.white),
                            onPressed: () {
                              state.selectedSeats.isNotEmpty
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookForm(
                                          movietitle: widget.movietitle,
                                          time: widget.time,
                                          date: widget.date,
                                          seats: state.selectedSeats,
                                          imgsrc: widget.imgsrc,
                                        ),
                                      ))
                                  : '';
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                  fontFamily: 'font1',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget get chairletter {
    return GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.15,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, index) => Text(
              String.fromCharCode(65 + index),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "font1",
                fontWeight: FontWeight.bold,
              ),
            ));
  }
}
