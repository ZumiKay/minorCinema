
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minor_cinemaapp/Bloc/cinema_bloc.dart';
import 'package:minor_cinemaapp/chair_selectPage.dart';

class Detail extends StatefulWidget {
  final String imageSrc, movietitle, moviedate, theater;
  String? selecteddate;
  final int dateCount;
  final List<String> time;
  Detail({
    Key? key,
    required this.theater,
    required this.imageSrc,
    required this.movietitle,
    required this.time,
    required this.dateCount,
    required this.moviedate,
  }) : super(key: key);
  @override
  DetailPage createState() => DetailPage();
}

class DetailPage extends State<Detail> {
  final DateTime now = DateTime.now();
  final DateFormat fomatter = DateFormat('dd-MMM-yyyy');
  final Stream db =
      FirebaseFirestore.instance.collection('tickets').snapshots();
  List<String> bookedseats = [];
  
  @override
  void initState() {
    super.initState();
    setState(() {
      widget.selecteddate = fomatter.format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(
          widget.movietitle,
          style: const TextStyle(fontFamily: 'font1'),
        ),
        backgroundColor: Colors.black,
      ),
      body: Stack(children: [
        
        Container(
          width: 200,
          height: 300,
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 100),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              image: DecorationImage(
                image: NetworkImage(widget.imageSrc),
                fit: BoxFit.cover,
              )),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                daysCount: widget.dateCount,
                dateTextStyle: const TextStyle(fontFamily: 'font1'),
                onDateChange: (date) {
                  setState(() {
                    widget.selecteddate = fomatter.format(date);
                  });
                },
              ),
              decoration: const BoxDecoration(color: Colors.grey),
            )
          ],
        ),
         Positioned(
          bottom: 200,
          child: 
         SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: const Card(
            color: Colors.grey,
            
            child: Center(
              child: Text(
                "2D KH/ENG",
                style: TextStyle(
                    fontFamily: 'font1',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
        )
        ,
        Positioned(
          top: 600,
          child:  
        Container(
          margin:const EdgeInsets.only(left: 10),
          child: Text(
            widget.theater,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'font1',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ))
       ,
       
       timecon(
          context,
          widget.time,
          widget.movietitle,
          widget.selecteddate ?? '',
          widget.imageSrc,
          widget.theater,
          bookedseats,
        )
       
        ,
      ]),
    );
  }
}

Widget timecon(BuildContext context, List<String> time, String movietitle,
    String date, String imagesrc, String threater, List<String> bookedseats) {
  return Container(
    margin: const EdgeInsets.only(top: 650),
    height: 200,
    child: GridView.builder(
      itemCount: time.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 4.0,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => CinemaBloc(),
                  child: Chair(
                    movietitle: movietitle,
                    time: time[index],
                    date: date,
                    imgsrc: imagesrc,
                    threater: threater,
                  ),
                ),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              time[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontSize: 15, fontFamily: 'font1'),
            ),
          ),
        ),
      ),
    ),
  );
}
