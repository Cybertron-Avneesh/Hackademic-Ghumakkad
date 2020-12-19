import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  final Function onEntry;
  final Function onExit;

  QRViewExample(this.onEntry, this.onExit);

  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final _numController = TextEditingController();
  QRViewController controller;
  var _isEntry = false;
  var _placeID = '';
  var _hasQRCode = false;
  var _numTickets = 0;

  @override
  void dispose() {
    controller?.dispose();
    _numController.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // Storing the String from the QR Code
        final qrText = scanData.toString();

        // The QR Code if Valid
        if (qrText.startsWith('GHUM')) {
          controller.pauseCamera();
          _hasQRCode = true;
          final _data = qrText.split("\$");

          // Decide if the User is Entering or Not & the ID of the Place
          if (_data[1] == 'true')
            _isEntry = true;
          else
            _isEntry = false;
          _placeID = _data[2];
          print(_data[1]);

          if (!_isEntry) {
            widget.onExit(_placeID, context);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // To ensure the Scanner view is properly sizes after rotation
                // we need to listen for Flutter SizeChanged notification and update controller
                Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.75,
                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor,
                              )),
                              child: NotificationListener<
                                  SizeChangedLayoutNotification>(
                                onNotification: (notification) {
                                  Future.microtask(() =>
                                      controller?.updateDimensions(qrKey));
                                  return false;
                                },
                                child: SizeChangedLayoutNotifier(
                                  key: const Key('qr-size-notifier'),
                                  child: QRView(
                                    key: qrKey,
                                    onQRViewCreated: _onQRViewCreated,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.75,
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: FlareActor('assets/qr_scanner.flr',
                                    animation: 'scan'))
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          "SCAN YOUR CODE",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ],
                    )),

                !_hasQRCode && !_isEntry
                    ? CircularProgressIndicator()
                    : Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextField(
                                cursorColor: Theme.of(context).primaryColor,
                                keyboardType: TextInputType.number,
                                controller: _numController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.confirmation_number),
                                  labelText: 'Number of Tickets',
                                  border: OutlineInputBorder(),
                                ),
                                onEditingComplete: () {
                                  FocusScope.of(context).unfocus();
                                },
                                onChanged: (val) {
                                  _numTickets = int.parse(val);
                                },
                              ),
                              RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  if (_numTickets <= 0) return;
                                  widget.onEntry(
                                      _placeID, _numTickets, context);
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
