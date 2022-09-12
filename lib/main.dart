import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectobaselinea2022_2/Vista/RegistroUser.dart';
import 'Vista/Login.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  HomeStart createState() => HomeStart();
}

class HomeStart extends State<Home> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienvenidos App Línea 2',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenidos'),
          backgroundColor: Colors.black45,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black45, minimumSize: Size(400, 50)),
                  onPressed: () {
                    print('Ingreso Login');
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Login()));
                  },
                  child: Text(
                    'Ingresar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black45, minimumSize: Size(400, 50)),
                  onPressed: () {
                    print('Ingreso registro');
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => RegistroUser()));
                  },
                  child: Text(
                    'Registrar',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
