import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;
  final bool hide;

  MessageTextField(this.currentId, this.friendId, this.hide);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  File? imageFile;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _getPermission() async => await [
        Permission.sms,
      ].request();

  Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;
  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;
  String? message;

  _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, App cannot request permissions.');
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;
    String? mid;

    // await _firestore
    //     .collection('users')
    //     .doc(widget.currentId)
    //     .collection('messages')
    //     .doc(widget.friendId)
    //     .collection('chats')
    //     .add({
    //   "senderId": widget.currentId,
    //   "receiverId": widget.friendId,
    //   "message": "",
    //   "type": "img",
    //   "date": DateTime.now(),
    // }).then((value) {
    //   // print(value.id);
    //   mid = value.id;
    // });

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('users')
          .doc(widget.currentId)
          .collection('messages')
          .doc(widget.friendId)
          .collection('chats')
          .doc(mid)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentId)
          .collection('messages')
          .doc(widget.friendId)
          .collection('chats')
          .add({
        "senderId": widget.currentId,
        "receiverId": widget.friendId,
        "message": imageUrl,
        "type": "img",
        "date": DateTime.now(),
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.friendId)
          .collection('messages')
          .doc(widget.currentId)
          .collection("chats")
          .add({
        "senderId": widget.currentId,
        "receiverId": widget.friendId,
        "message": imageUrl,
        "type": "img",
        "date": DateTime.now(),
      });

      print(imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.only(
        top: 8.0,
        start: 8.0,
        end: 8.0,
        bottom: 8.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Visibility(
              visible: !widget.hide,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.pink,
                ),
                child: TextField(
                  cursorColor: Colors.pink,
                  controller: _controller,
                  readOnly: widget.hide,
                  decoration: InputDecoration(
                    labelText: widget.hide == false
                        ? "Type your Message"
                        : "resolved you can not type",
                    fillColor: Colors.grey[100],
                    filled: true,
                    prefixIcon: Visibility(
                      visible: !widget.hide,
                      child: IconButton(
                          onPressed: () {
                            // getImage();
                            showModalBottomSheet(
                                backgroundColor:
                                    Color.fromARGB(255, 248, 133, 172),
                                context: context,
                                builder: (builder) {
                                  return bottomSheet();
                                });
                          },
                          icon: Icon(
                            Icons.add_box_rounded,
                            size: 30,
                            color: Color.fromARGB(255, 248, 133, 172),
                          )),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                      ),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () async {
              message = _controller.text;
              _controller.clear();
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.currentId)
                  .collection('messages')
                  .doc(widget.friendId)
                  .collection('chats')
                  .add({
                "senderId": widget.currentId,
                "receiverId": widget.friendId,
                "message": message,
                "type": "text",
                "date": DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .set({
                  'last_msg': message,
                });
              });

              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.friendId)
                  .collection('messages')
                  .doc(widget.currentId)
                  .collection("chats")
                  .add({
                "senderId": widget.currentId,
                "receiverId": widget.friendId,
                "message": message,
                "type": "text",
                "date": DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.friendId)
                    .collection('messages')
                    .doc(widget.currentId)
                    .set({"last_msg": message});
              });
            },
            child: Visibility(
              visible: !widget.hide,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 248, 133, 172),
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio", () {}),
                  SizedBox(
                    width: 25,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location", () {
                    _getCurrentLocation();
                    Future.delayed(Duration(seconds: 1), () {
                      message =
                          "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}";
                    }).then((value) async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.currentId)
                          .collection('messages')
                          .doc(widget.friendId)
                          .collection('chats')
                          .add({
                        "senderId": widget.currentId,
                        "receiverId": widget.friendId,
                        "message": message,
                        "type": "link",
                        "date": DateTime.now(),
                      }).then((value) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.currentId)
                            .collection('messages')
                            .doc(widget.friendId)
                            .set({
                          'last_msg': message,
                        });
                      });

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.friendId)
                          .collection('messages')
                          .doc(widget.currentId)
                          .collection("chats")
                          .add({
                        "senderId": widget.currentId,
                        "receiverId": widget.friendId,
                        "message": message,
                        "type": "link",
                        "date": DateTime.now(),
                      }).then((value) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.friendId)
                            .collection('messages')
                            .doc(widget.currentId)
                            .set({"last_msg": message});
                      });
                    });

                    print(_currentAddress);
                  }),
                  SizedBox(
                    width: 25,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera", () {}),
                  SizedBox(
                    width: 25,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",
                      () {
                    getImage();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      IconData icons, Color color, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
}
