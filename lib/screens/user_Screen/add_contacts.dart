import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:women_safety_fyp/screens/user_Screen/select_contact.dart';
import 'package:women_safety_fyp/services/db_helper.dart';
import 'package:women_safety_fyp/utils/t_contacts.dart';

class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<TContact>? contactList;
  int count = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //useEffect()
      updateListView();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      contactList = <TContact>[];
    }
    // Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Trusted Contacts",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 248, 133, 172),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonTheme(
                height: 70,
                minWidth: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    navigateToSelectContact();
                  },
                  elevation: 10,
                  highlightElevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    'Add a Trusted Contact',
                    style: TextStyle(fontSize: 25),
                  ),
                  textColor: Colors.white,
                  color: Color.fromARGB(255, 250, 163, 192),
                ),
              ),
              Expanded(
                child: getContactListView(),
                // padding: const EdgeInsets.all(20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView getContactListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1!;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              this.contactList![position].name,
              style: titleStyle,
            ),
            subtitle: Text(this.contactList![position].number),
            trailing: Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        tooltip: 'Call Contact',
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              contactList![position].number);
                          // _deleteContact(context, contactList![position]);
                        }),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      tooltip: 'Delete Contact',
                      onPressed: () {
                        _deleteContact(context, contactList![position]);
                      }),
                ],
              ),
            ),
            onTap: () {
              // log("ListTile Tapped");
            },
          ),
        );
      },
    );
  }

  void navigateToSelectContact() async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SelectContact();
    }));

    if (result == true) {
      updateListView();
    }
  }

  void _deleteContact(BuildContext context, TContact contact) async {
    int result = await databaseHelper.deleteContact(contact.id);
    if (result != 0) {
      Get.snackbar('', 'Contact Removed Successfully');
      // log('Contact Removed Successfully');
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactListFuture =
          databaseHelper.getContactList();
      contactListFuture.then((contactList) {
        setState(() {
          this.contactList = contactList;
          this.count = contactList.length;
        });
      });
    });
  }
}
