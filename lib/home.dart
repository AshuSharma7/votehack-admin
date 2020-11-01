import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _date;
  TextEditingController _id = new TextEditingController();
  TextEditingController _mobile = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 80.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Admin",
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            TextField(
              controller: _id,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                  hintText: "Voter ID", border: InputBorder.none),
            ),
            Divider(
              thickness: 1,
              height: 2,
              color: Colors.black87,
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _mobile,
              style: TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  hintText: "Mobile number", border: InputBorder.none),
            ),
            Divider(
              thickness: 1,
              height: 2,
              color: Colors.black87,
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () async {
                DateTime a = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                setState(() {
                  _date = (a.day.toString() +
                      "-" +
                      a.month.toString() +
                      "-" +
                      a.year.toString());
                });
              },
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(57, 106, 252, 0.2),
                        blurRadius: 10.0,
                        offset: Offset(0, 7.0))
                  ],
                  gradient: LinearGradient(
                      colors: [Color(0xFF396afc), Color(0xFF2948ff)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Center(
                  child: Text(
                    _date != null ? _date : "Select Date",
                    style: TextStyle(
                        fontFamily: "Josefin",
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: (context),
                    builder: (BuildContext context) {
                      return AlertDialog(content: Text("Please Wait"));
                    });
                FirebaseFirestore.instance.collection("admin").doc().set({
                  "voterId": _id.text,
                  "mobile": _mobile.text,
                  "electionDate": _date
                }).whenComplete(() {
                  Navigator.pop(context);
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                // duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(57, 106, 252, 0.2),
                        blurRadius: 10.0,
                        offset: Offset(0, 7.0))
                  ],
                  gradient: LinearGradient(
                      colors: [Color(0xFF396afc), Color(0xFF2948ff)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                // width: 70.0,
                // height: 70.0,
                // decoration: BoxDecoration(
                //     // color: Color(0xFF1165C1),
                //     gradient: LinearGradient(
                //         colors: [Color(0xFF396afc), Color(0xFF2948ff)],
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight),
                //     boxShadow: [
                //       BoxShadow(
                //           color: Color.fromRGBO(57, 106, 252, 0.3),
                //           blurRadius: 10.0,
                //           offset: Offset(3, 7.0))
                //     ],
                //     borderRadius: BorderRadius.circular(50.0)),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
