//import 'dart:js';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class Login extends StatefulWidget {
  @override
  LoginApp createState() => LoginApp();
}

class LoginApp extends State<Login> {
  TextEditingController correo = TextEditingController();
  TextEditingController pass = TextEditingController();

  final LocalAuthentication auth = LocalAuthentication();

  final firebase = FirebaseFirestore.instance;
  validarDatos() async {
    bool flag = false;
    try {
      CollectionReference ref = FirebaseFirestore.instance.collection("Users");
      print('***----1');
      QuerySnapshot usuario = await ref.get();
      if (usuario.docs.length != 0) {
        print('***----2');
        for (var cursor in usuario.docs) {
          print('**4444');
          if (correo.text == cursor.get('CorreoUsuario')) {
            print('***----3');
            if (pass.text == cursor.get('Pass')) {
              //idUser= cursor.id.toString();
              // flag = true;
              //mensaje('Mensaje', 'dato encontrado',idUser);

              print(cursor.id);
            }
          }
          //print(cursor.get('User'));
        } //if (!flag)
        // mensajeGeneral('Mensaje', 'dato no encontrado');

      }
    } catch (e) {
      //mensajeGeneral('Error', e.toString());
      print('**************ERROR***********************' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingrese sus credenciales'),
        backgroundColor: Colors.black45,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset('image/img.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: correo,
                style: TextStyle(color: Colors.blueGrey),
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Correo',
                  hintText: 'Digite su correo',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: pass,
                style: TextStyle(color: Colors.blueGrey),
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Contraseña',
                  hintText: 'Digite su contraseña',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black45, minimumSize: Size(400, 50)),
                onPressed: () {
                  print('Ingreso BBDD');
                  //inserDatatUser();
                  validarDatos();
                },
                child: Text(
                  'Enviar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(50, 50),
                  primary: Colors.black45,
                ),
                onPressed: () async {
                  print("dentro 111");
                  bool isSuccess = await biometrico();
                  print('Correcto --'+isSuccess.toString());

                  if (isSuccess){
                    print('Correcto');
                  }

                  //    print('success ' + isSuccess.toString());
                },
                child: Icon(Icons.fingerprint, size: 80),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> biometrico() async {
    //print("biométrico");

    // bool flag = true;
    bool authenticated = false;

    const androidString = const AndroidAuthMessages(
      cancelButton: "Cancelar",
      goToSettingsButton: "Ajustes",
      signInTitle: "Ingrese",
      //fingerprintNotRecognized: 'Error de reconocimiento de huella digital',
      goToSettingsDescription: "Confirme su huella",
      //fingerprintSuccess: 'Reconocimiento de huella digital exitoso',
      biometricHint: "Toque el sensor",
      //signInTitle: 'Verificación de huellas digitales',
      biometricNotRecognized: "Huella no reconocida",
      biometricRequiredTitle: "Required Title",
      biometricSuccess: "Huella reconocida",
      //fingerprintRequiredTitle: '¡Ingrese primero la huella digital!',
    );
    bool canCheckBiometrics = await auth.canCheckBiometrics;
  // bool isBiometricSupported = await auth.();
    bool isBiometricSupported = await auth.isDeviceSupported();


    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    print(canCheckBiometrics); //Returns trueB
    // print("support -->" + isBiometricSupported.toString());
    print(availableBiometrics.toString()); //Returns [BiometricType.fingerprint]
    try {
      authenticated = await auth.authenticate(
          localizedReason: "Autentíquese para acceder",
          useErrorDialogs: true,
          stickyAuth: true,
          //biometricOnly: true,
          androidAuthStrings: androidString);
      if (!authenticated) {
        authenticated = false;
      }
    } on PlatformException catch (e) {
      print(e);
    }
    /* if (!mounted) {
        return;
      }*/

    return authenticated;
  }

  void mensaje(String titulo, String mess) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mess),
            actions: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  //Navigator.of(context).pop();
                },
                child:
                    Text("Aceptar", style: TextStyle(color: Colors.blueGrey)),
              )
            ],
          );
        });
  }
}
