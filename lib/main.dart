import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  String studentName, studentID, studyProgramID;
  double studentGPA;

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id) {
    this.studentID = id;
  }

  getStudyProgramID(programID) {
    this.studyProgramID = programID;
  }

  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  createData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };

    documentReference.setData(students).whenComplete(() {
      print("$studentName created");
    });
  }

  readData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(studentName);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data["studentName"]);
      print(datasnapshot.data["studentID"]);
      print(datasnapshot.data["studyProgramID"]);
      print(datasnapshot.data["studentGPA"]);
    });
  }

  updateData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };

    documentReference.setData(students).whenComplete(() {
      print("$studentName updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyStudents").document(studentName);

    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flutter College"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Name",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onChanged: (String name) {
                      getStudentName(name);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Student ID",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onChanged: (String id) {
                      getStudentID(id);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Study Program ID",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onChanged: (String programID) {
                      getStudyProgramID(programID);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "GPA",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    onChanged: (String gpa) {
                      getStudentGPA(gpa);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: raisedButtonStyle1,
                      onPressed: () {
                        createData();
                      },
                      child: Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: raisedButtonStyle2,
                      onPressed: () {
                        readData();
                      },
                      child: Text(
                        "Read",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: raisedButtonStyle3,
                      onPressed: () {
                        updateData();
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: raisedButtonStyle4,
                      onPressed: () {
                        deleteData();
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Expanded(
                        child: Text("Name"),
                      ),
                      Expanded(
                        child: Text("Student ID"),
                      ),
                      Expanded(
                        child: Text("Program ID"),
                      ),
                      Expanded(
                        child: Text("GPA"),
                      )
                    ],
                  ),
                ),
                StreamBuilder(
                  stream:
                      Firestore.instance.collection("MyStudents").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data.documents[index];
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(documentSnapshot["studentName"]),
                                ),
                                Expanded(
                                  child: Text(documentSnapshot["studentID"]),
                                ),
                                Expanded(
                                  child:
                                      Text(documentSnapshot["studyProgramID"]),
                                ),
                                Expanded(
                                  child: Text(documentSnapshot["studentGPA"]
                                      .toString()),
                                )
                              ],
                            );
                          });
                    } else {
                      return Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final ButtonStyle raisedButtonStyle1 = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.green,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
final ButtonStyle raisedButtonStyle2 = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.blue,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
final ButtonStyle raisedButtonStyle3 = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.orange,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
final ButtonStyle raisedButtonStyle4 = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.red,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
