import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minor_cinemaapp/Customs/movie_icon_icons.dart';
import 'package:minor_cinemaapp/Customs/my_flutter_app_icons.dart';
import 'package:minor_cinemaapp/MovieModels.dart';
import 'package:minor_cinemaapp/book_form.dart';
import 'package:minor_cinemaapp/detail_page.dart';
import 'package:minor_cinemaapp/settings_page.dart';
import 'package:minor_cinemaapp/ticket_page.dart';
import 'package:page_transition/page_transition.dart';

GlobalKey globalKey = GlobalKey();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Minor());
}

class Minor extends StatefulWidget {
  const Minor({Key? key}) : super(key: key);

  @override
  MinorCinema createState() => MinorCinema();
}

class MinorCinema extends State<Minor> {
  int _currentIndex = 0;
  String _selectedButtom = 'NowShowing';
  List<Moviedata>? moviesList;
  List<Moviedata>? upcommingmovieList;
  Color iconColor = Colors.white;
  final controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchMovie(
            'https://api.themoviedb.org/3/movie/now_playing?api_key=1ab1c1e489ff7b73b8421d135545954d&language=en-US&page=1')
        .then((value) {
      setState(() {
        moviesList = value;
      });
    });
    fetchMovie(
            "https://api.themoviedb.org/3/movie/upcoming?api_key=1ab1c1e489ff7b73b8421d135545954d&language=en-US&page=1")
        .then((value) {
      setState(() {
        upcommingmovieList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //screenWidth = MediaQuery.of(context).size.width;

    Widget HomeScreen(BuildContext context) {
      List<Widget> _pages = <Widget>[bodypage1(context), Setting];
      return Scaffold(
        key: globalKey,
        endDrawer: sideMenu(context),
        backgroundColor: Colors.black,

        // appBar: PreferredSize(
        //   child: navBar,
        //   preferredSize: Size.fromHeight(50.0),
        // ),
        //_pages[_currentIndex]
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: navBar,
                    floating: true,
                    snap: true,
                    expandedHeight: 50.0,
                    forceElevated: innerBoxisScrolled,
                    backgroundColor: Colors.black,
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ticketsPages(context),
                                  type: PageTransitionType.bottomToTop));
                        },
                        icon: const Icon(
                          MovieIcon.ticket_1,
                          color: Colors.white,
                        ),
                        iconSize: 35,
                      )
                    ],
                  ))
            ];
          },
          body: Builder(
            builder: (BuildContext context) {
              return _pages[_currentIndex];
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: const Color(0xff575757),
          onTap: _onTappedtap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
                activeIcon: Icon(Icons.settings)),
          ],
        ),
      );
    }

    return MaterialApp(
      title: "Minor Cinema",
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(context),
        
      },
    );
  }

  Widget sideMenu(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            child: Center(
              child: Text(
                "Minor Cineplex",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
            },
          ),
          ListTile(
            leading: const Icon(MyFlutterApp.ticket_alt),
            title: const Text("My Tickets"),
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
        ],
      ),
    );
  }

  void _onTappedtap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget bodypage1(BuildContext context, {bool active = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              FilterButtom('NowShowing', active: true),
              FilterButtom("Comming Soon")
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 808,
          margin: const EdgeInsets.only(top: 20),
          child: moviesList == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  controller: controller,
                  itemCount: 5,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6095,
                  ),
                  itemBuilder: (context, index) {
                    return _selectedButtom != 'Comming Soon'
                        ? movieContainer(
                            'https://image.tmdb.org/t/p/w500${moviesList![index].posterPath}',
                            '${moviesList![index].title}',
                            context,
                            ['12:00', '11:00'],
                            5,
                            '${moviesList![index].release_date}')
                        : movieContainer(
                            'https://image.tmdb.org/t/p/w500${upcommingmovieList![index].posterPath}',
                            '${upcommingmovieList![index].title}',
                            context,
                            ['12:00', '11:00'],
                            5,
                            '${upcommingmovieList![index].release_date}');
                  }),
        )
      ],
    );
  }

  Widget movieContainer(String imagesrc, String title, BuildContext context,
      List<String> Time, int datecount, String relaease_date) {
    var date = DateTime.now();
    String dateformated = DateFormat('MMM-dd-yyyy').format(date);
    return GestureDetector(
      onTap: () {
        _selectedButtom != "Comming Soon"
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Detail(
                      imageSrc: imagesrc,
                      movietitle: title,
                      time: Time,
                      dateCount: datecount,
                      moviedate: relaease_date,
                    )))
            : '';
      },
      child: Column(
        children: [
          Container(
            height: 350,
            width: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: const Color(0xff8D5959),
              image: DecorationImage(
                  image: imagesrc != ''
                      ? NetworkImage(imagesrc)
                      : const NetworkImage(
                          'https://martialartsplusinc.com/wp-content/uploads/2017/04/default-image-620x600.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 60,
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  relaease_date,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'font1',
                      fontWeight: FontWeight.w200,
                      fontSize: 10),
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'font1',
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget FilterButtom(String title, {bool active = false}) {
    bool active = title == _selectedButtom;

    return GestureDetector(
        onTap: () => _onButtomFiltered(title),
        child: Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: active
                    ? [Colors.purple, Colors.pink]
                    : [Colors.grey, Colors.grey]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 150,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }

  void _onButtomFiltered(title) {
    setState(() {
      _selectedButtom = title;
    });
  }
}

Widget get navBar {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
    child: Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              "images/Logo.jpg",
              width: 50,
            ),
          ),
        ),
        Flexible(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "Minor",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text("Cineplex", style: TextStyle(fontSize: 15))
          ],
        ))
      ],
    ),
  );
}

void onMenuClick() {
  print("Clicked");
}

Widget bottomNav(int _currentindex) {
  return BottomNavigationBar(
    currentIndex: _currentindex,
    backgroundColor: const Color(0xff575757),
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.ticket_alt),
          label: "Tickets",
          activeIcon: Icon(MyFlutterApp.ticket_alt)),
      BottomNavigationBarItem(
          icon: Icon(Icons.security_update_warning_rounded), label: "Setting")
    ],
  );
}
