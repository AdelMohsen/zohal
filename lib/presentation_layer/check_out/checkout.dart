import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timelines/timelines.dart';
import 'package:zohal/elements/check_out_widgets.dart';
import 'package:zohal/elements/payment/payment_pages.dart';
import 'package:zohal/elements/payment/shopping_address_page.dart';
import 'package:zohal/elements/payment/shopping_cart_page.dart';

const kTileHeight = 50.0;

Color completeColor = HexColor('#0044FF');
Color inProgressColor = HexColor('#FF6600');
Color todoColor = HexColor('#707070');

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int _processIndex = 0;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.next_plan_outlined),
        onPressed: () {
          setState(() {
            _processIndex = (_processIndex + 1) % processes.length;
          });
        },
        backgroundColor: inProgressColor,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: HexColor('#072C3F'),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
              color: HexColor('#C0C0C0'),
            )),
      ),
      body: ListView(
        children: [
          //build_Time_Line_Start
          SizedBox(
            height: 90.0,
            width: double.infinity,
            child: Timeline.tileBuilder(
              theme: TimelineThemeData(
                direction: Axis.horizontal,
                connectorTheme: const ConnectorThemeData(
                  space: 30.0,
                  thickness: 3.0,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemExtentBuilder: (_, __) =>
                    MediaQuery.of(context).size.width / processes.length,
                oppositeContentsBuilder: (context, index) {
                  return null;
                },
                contentsBuilder: (context, index) {
                  return Text(
                    processes[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getColor(index),
                    ),
                  );
                },
                indicatorBuilder: (_, index) {
                  Color color;
                  var child;
                  if (index == _processIndex) {
                    color = inProgressColor;
                    child = const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  } else if (index < _processIndex) {
                    color = completeColor;
                    child = const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15.0,
                    );
                  } else {
                    color = todoColor;
                  }

                  if (index <= _processIndex) {
                    return Stack(
                      children: [
                        CustomPaint(
                          size: const Size(30.0, 30.0),
                          painter: BezierPainter(
                            color: color,
                            drawStart: index > 0,
                            drawEnd: index < _processIndex,
                          ),
                        ),
                        DotIndicator(
                          size: 30.0,
                          color: color,
                          child: child,
                        ),
                      ],
                    );
                  } else {
                    return Stack(
                      children: [
                        CustomPaint(
                          size: const Size(15.0, 15.0),
                          painter: BezierPainter(
                            color: color,
                            drawEnd: index < processes.length - 1,
                          ),
                        ),
                        OutlinedDotIndicator(
                          borderWidth: 4.0,
                          color: color,
                        ),
                      ],
                    );
                  }
                },
                connectorBuilder: (_, index, type) {
                  if (index > 0) {
                    if (index == _processIndex) {
                      final prevColor = getColor(index - 1);
                      final color = getColor(index);
                      List<Color> gradientColors;
                      if (type == ConnectorType.start) {
                        gradientColors = [
                          Color.lerp(prevColor, color, 0.5)!,
                          color
                        ];
                      } else {
                        gradientColors = [
                          prevColor,
                          Color.lerp(prevColor, color, 0.5)!
                        ];
                      }
                      return DecoratedLineConnector(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                          ),
                        ),
                      );
                    } else {
                      return SolidLineConnector(
                        color: getColor(index),
                      );
                    }
                  } else {
                    return null;
                  }
                },
                itemCount: processes.length,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          //build_Time_Line_End

          //build_Shopping_Cart_Page_Start
          if (_processIndex == 0) buildShoppingCartPage(),
          //build_Shopping_Cart_Page_End

          //build_Shopping_Address_Page_Start
          if (_processIndex == 1) buildShoppingAddressPage(),
          //build_Shopping_Address_Page_End

          //build_payment_page_start
          if (_processIndex == 2) const PaymentPage(),
          //build_payment_page_end
        ],
      ),
    );
  }
}
