import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
        backgroundColor: Color.fromARGB(235, 255, 255, 255),
            title: Container(
                height: 50, child: Center(child: CircularProgressIndicator(color:Color.fromARGB(255, 184, 3, 178) ))),
            content: Text(
              "شكرا على انتضارك ووقتك",
              style: TextStyle(
                  color: Color.fromARGB(255, 23, 22, 23),
                  fontSize: 20,
                  fontFamily: "Tajawal"),
            ));
      });
}
