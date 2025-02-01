
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      theme: ThemeData(
        primaryColor: Colors.teal,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(102, 124, 137,1),
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        scaffoldBackgroundColor: Colors.grey.shade300,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final List<Map<String, String>> _contacts = [];

  void _addContact() {
    if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
      setState(() {
        _contacts.insert(0, {
          "name": nameController.text,
          "number": numberController.text,
        });
        nameController.clear();
        numberController.clear();
      });
    }
  }


  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          content: const Text("Are you sure for Delete?"),
          actions: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.cancel, color: Colors.grey),
            ),
            IconButton(
              onPressed: () {
                _deleteContact(index);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: numberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Number",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Number";
                        }
                      if (value.length < 10 || value.length > 11) {
                        return "Please Enter 11 Number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(102, 124, 137,1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addContact();
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => _showDeleteDialog(index),
                    child: Card(
                      // elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      child: ListTile(
                        title: Text(_contacts[index]["name"]!),
                        subtitle: Text(_contacts[index]["number"]!),
                        leading: const Icon(Icons.person,size: 40,),
                        trailing: const Icon(Icons.call,size: 30,color: Colors.blueAccent,),
                        titleTextStyle: TextStyle(color: Colors.red.shade500,fontWeight: FontWeight.bold,fontSize: 15),

                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
