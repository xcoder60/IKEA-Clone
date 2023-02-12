import 'package:ar_app/presentaion/Home_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main()async {

  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  }

  catch(errorMSg){
    print("Error::"+ errorMSg.toString());

  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter iKEA Clone App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}


