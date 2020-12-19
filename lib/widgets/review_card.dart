import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    @required this.message,
    @required this.author,
    @required this.rating,
    // @required this.mainHeading,
  }) : super(key: key);

  final String message;
  final String author;
  final double rating;
  // final String mainHeading;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
            color: Theme.of(context).accentColor.withOpacity(0.3),
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text('$message'),
                      )),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "- $author",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Container(
                                height: 20,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "$rating",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
