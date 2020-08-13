import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:greenify/pages/home/event.dart';
import 'package:greenify/pages/home/leaderboard.dart';
import 'package:greenify/pages/home/main.dart';
import 'package:greenify/pages/home/profile.dart';
import 'package:greenify/pages/home/scanner.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final tabs = [
    MainPage(),
    EventList(),
    QRScanner(),
    Leaderboard(),
    EditProfilePage()
  ];

  final colors = [
    Colors.pink,
    Colors.lightBlue[600],
    Colors.teal,
    Colors.yellow[900],
    Colors.green[600]
  ];

  Color _getBgColor(int index) =>
      _currentIndex == index ? colors[_currentIndex] : Colors.black;

  Widget _buildIcon(IconData iconData, String text, int index) => Container(
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      child: Material(
        color: _getBgColor(index),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData, color: Colors.white),
              Text(text,
                  style: TextStyle(fontSize: 12, color :Colors.white)),
            ],
          ),
        ),
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: _buildIcon(Icons.home, 'Home', 0),
              title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
              icon: _buildIcon(Icons.calendar_today, 'Events', 1),
              title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
              icon: _buildIcon(FontAwesomeIcons.qrcode, 'Scan', 2),
              title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
              icon: _buildIcon(Icons.list, 'Leaderboard', 3),
              title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
              icon: _buildIcon(Icons.settings, 'Settings', 4),
              title: SizedBox.shrink(),
          ),
        ],
        onTap: (index) => {
          setState(() {
            _currentIndex = index;
          })
        },
      ),
    );
  }
}
