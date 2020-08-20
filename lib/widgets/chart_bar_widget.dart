import 'dart:math';

import 'package:EkonoMe/models/ChartItemModel.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class ChartBar extends StatefulWidget {
  final ChartItemModel item;

  ChartBar(this.item);

  @override
  _ChartBarState createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  int selectedIndex = -1;
  Random random = new Random();

  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.amber,
    Colors.pink,
    Colors.purple[300]
  ];

  @override
  void initState() {
    super.initState();
    this.selectedIndex = random.nextInt(5);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimation(
      duration: Duration(
        milliseconds: 500,
      ),
      tween: Tween(begin: 0.0, end: this.widget.item.percentage * 100),
      builder: (context, child, value) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    this.widget.item.label,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    this.widget.item.displayedAmount,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: this.colors[this.selectedIndex],
                  ),
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: this.colors[this.selectedIndex],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      width: (this.widget.item.percentage >= 0.9
                              ? this.widget.item.percentage - 0.05
                              : this.widget.item.percentage) *
                          MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
