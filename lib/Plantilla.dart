import 'package:flutter/material.dart';

class Geo extends StatefulWidget{
  GeoApp createState() => GeoApp();
}
class GeoApp extends State<Geo>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocalización'),

      ),
      body: SingleChildScrollView(),
    );
  }
}