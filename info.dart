import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  static const String KEYNAME = "name";
  static const String KEYEMAIL = "email";
  static const String KEYSHIFT = "shift";
  static const String KEYDEGREE = "degree";

  String nameValue = "No value saved";
  String emailValue = "No value saved";
  String shiftValue = "No value saved";
  String degreeValue = "No value saved";

  @override
  void initState() {
    super.initState();
    getValue();
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString(KEYNAME);
    var getEmail = prefs.getString(KEYEMAIL);
    var getShift = prefs.getString(KEYSHIFT);
    var getDegree = prefs.getString(KEYDEGREE);

    setState(() {
      nameValue = getName ?? "No value saved";
      emailValue = getEmail ?? "No value saved";
      shiftValue = getShift ?? "No value saved";
      degreeValue = getDegree ?? "No value saved";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Record of User",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.teal,
        child: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Name: $nameValue',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Email: $emailValue',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Shift: $shiftValue',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Degree: $degreeValue',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
