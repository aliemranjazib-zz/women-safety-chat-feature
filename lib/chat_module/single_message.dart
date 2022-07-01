import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_fyp/chat_module/chat_screen.dart';
import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String? message;
  final bool? isMe;
  final String? img;
  final String? type;
  final String? friendname;
  final String? myname;
  final Timestamp? date;

  SingleMessage(
      {this.message,
      this.isMe,
      this.img,
      this.type,
      this.friendname,
      this.date,
      this.myname});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime d = DateTime.parse(date!.toDate().toString());

    String cdate = "${d.hour}" + ":" + "${d.minute}";

    return type == 'text'
        ? Container(
            // width: size.width / 2,
            constraints: BoxConstraints(
              maxWidth: size.width / 2,
            ),
            alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
            child: GestureDetector(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: size.width / 2,
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: isMe!
                      ? BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                  color:
                      isMe! ? Color.fromARGB(255, 248, 133, 172) : Colors.black,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        isMe! ? myname! : friendname!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Divider(),
                    Text(
                      message!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Divider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        cdate,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : type == 'link'
            ? Container(
                // width: size.width / 2,
                constraints: BoxConstraints(
                  maxWidth: size.width / 2,
                ),
                alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
                child: GestureDetector(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: size.width / 2,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: isMe!
                          ? BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                      color: isMe! ? Colors.redAccent : Colors.redAccent,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.location_on),
                              Text(
                                isMe! ? myname! : friendname!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        TextButton(
                          onPressed: () async {
                            await launch("$message");
                          },
                          child: Text(
                            message!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Divider(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            cdate,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                height: size.height / 2.5,
                width: size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ShowImage(
                        imageUrl: message!,
                      ),
                    ),
                  ),
                  child: Container(
                    height: size.height / 2.5,
                    width: size.width / 2,
                    // decoration: BoxDecoration(border: Border.all()),
                    alignment: message! != "" ? null : Alignment.center,
                    child: message! != ""
                        ? CachedNetworkImage(
                            imageUrl: message!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : CircularProgressIndicator(),
                  ),
                ),
              );

    // Row(
    //   mainAxisAlignment:
    //       isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
    //   children: [
    //     Container(
    //       padding: EdgeInsets.all(16),
    //       margin: EdgeInsets.all(16),
    //       constraints: BoxConstraints(
    //         maxWidth: 200,
    //       ),
    //       decoration: BoxDecoration(
    //         color: isMe! ? Colors.black : Colors.orange,
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(12),
    //         ),
    //       ),
    //       child: Text(
    //         message!,
    //         style: TextStyle(
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
