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
        title: Text('Bill Screen'),
      ),
      body: Column(
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
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '\$  ${_bill.price.toString()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(height: 60),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      " ${_bill.placeName}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(
                            "${_bill.numPer}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.6,
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(
                            "$formattedDate",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton.extended(
        elevation: 0.0,
        label: Text('All Tickets'),
        icon: Icon(Icons.payment),
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
