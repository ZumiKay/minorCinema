import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:minor_cinemaapp/Bloc/cinema_bloc.dart';
import 'package:minor_cinemaapp/chair_selectPage.dart';
import 'package:minor_cinemaapp/firestore.dart';


class Detail extends StatefulWidget {
  final String imageSrc, movietitle, moviedate;
  String? selecteddate;
  final int dateCount;
  final List<String> time;
  Detail(
      {Key? key,
      required this.imageSrc,
      required this.movietitle,
      required this.time,
      required this.dateCount,
      required this.moviedate,
      })
      : super(key: key);
  @override
  DetailPage createState() => DetailPage();
}

class DetailPage extends State<Detail> {
  final DateTime now = DateTime.now();
  final DateFormat fomatter = DateFormat('dd-MMM-yyyy');

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      widget.selecteddate = fomatter.format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(
          widget.movietitle,
          style: const TextStyle(fontFamily: 'font1'),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(children: [
        Center(
            child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              image: DecorationImage(
                image: NetworkImage(widget.imageSrc),
                fit: BoxFit.cover,
              )),
        )),
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
        const SizedBox(
          width: 500,
          height: 60,
          child: Card(
            color: Colors.grey,
            margin: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                "2D KH/ENG",
                style: TextStyle(fontFamily: 'font1', fontSize: 20),
              ),
            ),
          ),
        ),
        timecon(context, widget.time, widget.movietitle, widget.selecteddate ?? '' , widget.imageSrc)
      ]),
    );
  }
}

Widget timecon(
    BuildContext context, List<String> time, String movietitle, String date , String imagesrc) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    height: 300,
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
                  builder: (context) => BlocProvider(create: (context) => CinemaBloc() , child: Chair(
                        movietitle: movietitle,
                        time: time[index],
                        date: date,
                        imgsrc:imagesrc ,
                      ),)));
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
