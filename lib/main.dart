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
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          centerTitle: true
        ),
        scaffoldBackgroundColor: Colors.grey.shade300
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
   MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return  Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),

      body: Column(
        children: [
          Form(
              key: _formKey,
              child: Padding(padding: EdgeInsets.all(10),child: Column(
            children: [
              TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name"
                  ),
                validator: (value){
                    if(value ==null || value.isEmpty){
                      return "Please Enter Your Name";
                    }
                    return null;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Number",
                  ),
                keyboardType: TextInputType.number,
                validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please Enter Your Number";
                    }
                    return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          enabledMouseCursor: MouseCursor.defer
                      ),
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          print("Success");
                        }
                      }, child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)))
            ],
          ),))
        ],
      ),
    );
  }
}
