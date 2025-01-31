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
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              centerTitle: true),
          scaffoldBackgroundColor: Colors.grey.shade300),
      home: MyHomePage(),
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

  List<Map<String, String>> _contacts = [];

  void _addContact() {
    if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
      setState(() {
        _contacts.add({
          "name": nameController.text,
          "number": numberController.text,
        });
        nameController.clear();
        numberController.clear();
      });
    }
  }

   _deleteContact(int index){
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _showDeleteDialog(int index){

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
                        border: OutlineInputBorder(), hintText: "Name"),
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
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
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
                            fontWeight: FontWeight.bold),
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
                  return ElevatedButton(
                    onPressed: _deleteContact(index),
                        child: Card(
                      child: ListTile(
                        title: Text(_contacts[index]["name"]!),
                        trailing: Icon(Icons.call),
                        subtitle: Text(_contacts[index]["number"]!),
                        leading: Icon(Icons.person),
                        // onLongPress: () => _showDeleteDialog(index),
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
