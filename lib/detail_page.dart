import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  String imageSrc, movietitle;
  int dateCount;
  List<String> time;
  DetailPage(
      {Key? key,
      required this.imageSrc,
      required this.movietitle,
      required this.time , 
      required this.dateCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(
          movietitle,
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
                image: NetworkImage(imageSrc),
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
                daysCount: dateCount,
                dateTextStyle: const TextStyle(fontFamily: 'font1'),
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
        timecon(context, time)
      ]),
    );
  }
}

Widget timecon(BuildContext context, List<String> time) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    height: 300,
    child: GestureDetector(
      onTap: () => {Navigator.pushNamed(context, '/reserve')},
      child: GridView.builder(
          itemCount: time.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 4.0,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0),
          itemBuilder: (context, index) => SizedBox(
                child: Container(
                  
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      time[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'font1'),
                    ),
                  ),
                ),
              )),
    ),
  );
}
