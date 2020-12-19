import 'package:flutter/material.dart';

import '../models/place.dart';
import '../screens/place_screen.dart';

class PlaceCard extends StatelessWidget {
  final Place _place;
  const PlaceCard(this._place);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
      key: ValueKey(_place.id),
      clipBehavior: Clip.antiAlias,
      shadowColor: Theme.of(context).primaryColor,
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
              image: NetworkImage(_place.img),
              height: MediaQuery.of(context).size.width / 1.5,
              width: MediaQuery.of(context).size.width / 1.2,
              fit: BoxFit.cover,
            ),
          Container(
            height: MediaQuery.of(context).size.width / 1.5,
            width: MediaQuery.of(context).size.width / 1.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Theme.of(context).primaryColor, Colors.transparent],
              ),
            ),
          ),
          Positioned(
            child: Text(
              _place.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            left: 10,
            bottom: 10,
          ),
          Positioned(
            top: 2,
            right: 10,
            child: Chip(
              backgroundColor: Theme.of(context).accentColor,
              label: Text(
                "${_place.liveCnt}",
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
              ),
              avatar: Icon(Icons.location_history, color: Colors.black),
            ),
          ),
          InkWell(
            child: Container(
              height: MediaQuery.of(context).size.width / 1.5,
              width: MediaQuery.of(context).size.width / 1.2,
              color: Colors.transparent,
            ),
            splashColor: Theme.of(context).primaryColor,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(PlaceScreen.routeName, arguments: _place);
            },
          ),
        ],
      ),
    );
  }
}
