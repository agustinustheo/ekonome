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
  Color selectedColor;

  Color defineColor() {
    Color resultColor;
    if (this.widget.item.percentage >= 0.51) {
      resultColor = Color.fromRGBO(
          (255 - (255 * this.widget.item.percentage)).toInt(), 255, 0, 1);
    } else {
      resultColor = Color.fromRGBO(
          255, (255 - (255 * (1 - this.widget.item.percentage)).toInt()), 0, 1);
    }
    return resultColor;
  }

  @override
  void initState() {
    super.initState();
    this.selectedColor = this.defineColor();
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
                    color: this.selectedColor,
                  ),
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: this.selectedColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      width: this.widget.item.percentage *
                          (MediaQuery.of(context).size.width - 99),
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
