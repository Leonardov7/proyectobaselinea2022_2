import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:encrypt/encrypt.dart' as encrypt;


class RegistroUser extends StatefulWidget {
  @override
  RegistroUserApp createState() => RegistroUserApp();
}

class RegistroUserApp extends State<RegistroUser> {
  TextEditingController correo = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController pass = TextEditingController();

  final firebase = FirebaseFirestore.instance;
  inserDatatUser() async {
    print('1111111111111111111');
    try {
      await firebase.collection("Users").doc().set({
        "NombreUsuario": nombre.text,
        "CorreoUsuario": correo.text,
        "Pass": pass.text,
        "Estado": true,
        "Rol": "Usuario"
      });
      print("CORRECTO*****************");
      //mensaje("Ingreso", "Usuario registrado correctamente");
    } catch (e) {
      print('ERROR--> ' + e.toString());
    }
    //String clave=KEY_LOCAL_AUTH_ENABLED;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro usuario'),
        backgroundColor: Colors.black45,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nombre,
                style: TextStyle(color: Colors.blueGrey),
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Nombre usuario',
                  hintText: 'Digite su nombre',
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
                  print('Ingreso resgitro datos');
                  //inserDatatUser();

                  final key = encrypt.Key.fromSecureRandom(32);
                  final iv = IV.fromSecureRandom(16);
                  final encrypter = Encrypter(AES(key));
                  final encrypted = encrypter.encrypt(pass.text, iv: iv);
                 // print(decrypted);
                  print(key);
                  print('Password----->'+encrypted.bytes.toString());
                  print(encrypted.base16);
                  print(encrypted.base64);
                },
                child: Text(
                  'Ingresar datos',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
