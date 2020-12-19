import 'package:flutter/material.dart';

class NewReview extends StatefulWidget {
  final Function addReview;
  NewReview(this.addReview);

  @override
  _NewReviewState createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {
  final _ratingFN = FocusNode();
  final _descController = TextEditingController();
  final _ratingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _ratingFN.dispose();
    _descController.dispose();
    _ratingController.dispose();
  }

  void _submitData() {
    if (_ratingController.text.isEmpty) return;
    final enteredDesc = _descController.text;
    final enteredRating = double.parse(_ratingController.text);

    if (enteredDesc.isEmpty || enteredRating <= 0 || enteredRating > 5) {
      return;
    }

    widget.addReview(desc: enteredDesc, rating: enteredRating);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                controller: _descController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_ratingFN);
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Rating',
                ),
                controller: _ratingController,
                focusNode: _ratingFN,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              RaisedButton(
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text('Add Review'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
