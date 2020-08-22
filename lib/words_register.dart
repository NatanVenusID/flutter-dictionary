import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginregister_php/search_page.dart';
import 'package:loginregister_php/splashpage.dart';


class PageRegister extends StatefulWidget {
  @override
  _PageRegisterState createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  TextEditingController cIstilah = TextEditingController();
  TextEditingController cArti = TextEditingController();
//deklarasi untuk masing-masing widget
  String nIstilah, nArti;
//menambahkan key form
  final _keyForm = GlobalKey<FormState>();

  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();
      submitDataRegister();
    }
  }

// submit data register
  submitDataRegister() async {
    final responseData =
        await http.post("http://10.0.2.2/dictionary-server/register.php", body: {
      "istilah": nIstilah,
      "arti": nArti,
    });
    final data = jsonDecode(responseData.body);
    int value = data['value'];
    String pesan = data['message'];
//cek value 1 atau 0
    if (value == 1) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SplashPage()));
      });
    } else if (value == 2) {
      print(pesan);
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Form(
        key: _keyForm,
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                'Entry Term of Flutter',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                    color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 136,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/flutter.png"))),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                controller: cIstilah,
                validator: (value) {
                  //cek kalau value nya kosong
                  if (value.isEmpty) {
                    return 'Masukkan Istilah yang anda ingin tambahkan!';
                  }
                  return null;
                },
                onSaved: (value) => nIstilah = cIstilah.text,
                decoration: InputDecoration(
                    hintText: 'Istilah',
                    labelText: 'Masukkan Istilah',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                controller: cArti,
                validator: (value) {
                  //cek kalau value nya kosong
                  if (value.isEmpty) {
                    return 'Masukkan arti istilah';
                  }
                  return null;
                },
                onSaved: (value) => nArti = cArti.text,
                decoration: InputDecoration(
                    hintText: 'Arti Kata',
                    labelText: 'Input Arti Kata',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0),
              child: MaterialButton(
                color: Colors.black,
                textColor: Colors.white,
                child: Text('Entry Data Now'),
                onPressed: () {
                  setState(() {
                    checkForm();
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
              child: MaterialButton(
                textColor: Colors.blueGrey,
                child: Text('Start looking some words ? Search Now'),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
