import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/bill.dart';

class BillScreen extends StatelessWidget {
  static const routeName = '/bill';

  @override
  Widget build(BuildContext context) {
    final _bill = ModalRoute.of(context).settings.arguments as Bill;
    String formattedDate =
        DateFormat.yMMMEd('en-US').add_jm().format(_bill.time);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Your Bill'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CurvedBottomClipper(),
              child: Container(
                  color: Theme.of(context).primaryColor,
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '\$  ${_bill.price.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 60),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: FlareActor('assets/animated_money_wallet.flr',
                        alignment: Alignment.bottomCenter,
                        animation: 'coins_out'),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(
                            " ${_bill.placeName}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.20,
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.confirmation_num,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "${_bill.numPer}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.65,
                            color: Theme.of(context).primaryColor,
                            child: Center(
                              child: Text(
                                "$formattedDate",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 40,
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        elevation: 0.0,
        label: Text(
          'Proceed To Pay',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.payment, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}
