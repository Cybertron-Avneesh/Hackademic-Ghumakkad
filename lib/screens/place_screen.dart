import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/review_card.dart';
import '../widgets/new_review.dart';
import '../models/place.dart';
import '../models/review.dart';

class PlaceScreen extends StatefulWidget {
  static const routeName = '/place';

  @override
  _PlaceScreenState createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  Place _place;

  void _addReview({
    String desc,
    double rating,
  }) async {
    // Get the Current User Document
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    // Make a New Review for the DB
    final reviewDB = {
      'desc': desc,
      'name': userData['name'],
      'rating': rating,
    };

    // Make a New Review for the Local Variable
    final reviewLocal = new Review(
      desc: desc,
      name: userData['name'],
      rating: rating,
    );

    // Get the Selected Place
    final selPlaceFuture =
        FirebaseFirestore.instance.collection('places').doc(_place.id);
    final selPlace = await selPlaceFuture.get();
    final selReviews = selPlace['reviews'];

    // Update the Reviews Array (in DB & in Locally)
    final newReviewsArr = [...selReviews, reviewDB];
    _place.reviews = [..._place.reviews, reviewLocal];
    selPlaceFuture.update({
      'reviews': newReviewsArr,
    });
    setState(() {});
  }

  void _startAddNewRev(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewReview(_addReview);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    _place = ModalRoute.of(context).settings.arguments as Place;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  _place.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: Image.network(
                  _place.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_pin,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text(
                          _place.city,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(Icons.link),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    width: width,
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _place.desc,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Text(
                    "Reviews",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: _place.reviews.length,
                  itemBuilder: (context, i) {
                    return ReviewCard(
                      message: _place.reviews[i].desc,
                      author: _place.reviews[i].name,
                      rating: _place.reviews[i].rating,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewRev(context),
        child: Icon(Icons.rate_review),
      ),
    );
  }
}
