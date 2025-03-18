import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  static const String KEYNAME = "name";
  static const String KEYEMAIL = "email";
  static const String KEYDEGREE = "degree";
  static const String KEYSHIFT = "shift";

  String nameValue = "No value saved";
  String emailValue = "No value saved";
  String shiftValue = "No value saved";
  String degreeValue = "No value saved";
  String? selectedShift;
  String? selectedDegree;

  final List<String> degreeList = [
    "Computer Science",
    "Information Technology",
    "BBA",
    "Botany",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text(
            "Shared Preferences",
            style: TextStyle(color: Colors.white),
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.info, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfoScreen()),
                  );
                },
              );
            },
          )),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.teal,
        child: Center(
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(25.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
                const SizedBox(height: 11),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
                const SizedBox(height: 11),
                DropdownButtonFormField<String>(
                  value: selectedDegree,
                  decoration: InputDecoration(
                    labelText: "Select Degree",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                  items: degreeList.map((String degree) {
                    return DropdownMenuItem<String>(
                      value: degree,
                      child: Text(degree),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDegree = value;
                    });
                  },
                ),
                const SizedBox(height: 11),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text("Morning"),
                        leading: Radio<String>(
                          value: "morning",
                          groupValue: selectedShift,
                          onChanged: (value) {
                            setState(() {
                              selectedShift = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text("Evening"),
                        leading: Radio<String>(
                          value: "evening",
                          groupValue: selectedShift,
                          onChanged: (value) {
                            setState(() {
                              selectedShift = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    var prefs = await SharedPreferences.getInstance();
                    await prefs.setString(KEYNAME, nameController.text);
                    await prefs.setString(KEYEMAIL, emailController.text);
                    if (selectedShift != null) {
                      await prefs.setString(KEYSHIFT, selectedShift!);
                    }
                    if (selectedDegree != null) {
                      await prefs.setString(KEYDEGREE, selectedDegree!);
                    }
                    setState(() {
                      nameValue = nameController.text;
                      emailValue = emailController.text;
                      shiftValue = selectedShift ?? "No value saved";
                      degreeValue = selectedDegree ?? "No value saved";
                      nameController.clear();
                      emailController.clear();
                      selectedDegree = null;
                    });
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
