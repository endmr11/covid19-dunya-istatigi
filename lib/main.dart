import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> veriListem = [];
  verileriCagir() {
    http.get(Uri.parse("https://api.collectapi.com/corona/countriesData"),
        headers: {
          HttpHeaders.authorizationHeader: 'apikey //kendi tokenınızı girin//'
        }).then((cevap) {
      var durum = cevap.statusCode.toString();
      print("DURUM: $durum");
      var jsonCevap = convert.jsonDecode(cevap.body) as Map<String, dynamic>;
      //print(jsonCevap['result']);
      for (var i = 0; i < jsonCevap['result'].length; i++) {
        veriListem.add(jsonCevap['result']);
        //print(veriListem[i]);
      }

      /*for (var x = 0; x < jsonCevap['result'].length; x++) {
        print(veriListem[x][x]['totalCases']);
      }*/
      //print(veriListem[0][10]['country']);
      setState(() {});
    });
  }

  @override
  void initState() {
    verileriCagir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Covid-19 Dünya İstatiği",
          ),
          centerTitle: true,
        ),
        body: VerilerListesi(veriListem: veriListem),
      ),
    );
  }
}

class VerilerListesi extends StatelessWidget {
  const VerilerListesi({
    Key key,
    @required this.veriListem,
  }) : super(key: key);

  final List veriListem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: veriListem.length,
        itemBuilder: (BuildContext context, index) {
          return Card(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.elliptical(20, 40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Ülke: ${veriListem[0][index]['country']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Toplam Vaka: ${veriListem[0][index]['country']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Yeni Vaka: ${veriListem[0][index]['totalCases']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Toplam Ölüm: ${veriListem[0][index]['newCases']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Yeni Ölüm: ${veriListem[0][index]['totalDeaths']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Toplam İyileşen: ${veriListem[0][index]['totalRecovered']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Aktif Vaka: ${veriListem[0][index]['activeCases']}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
