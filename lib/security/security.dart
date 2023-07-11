import 'package:flutter/material.dart';

Widget deleteSession(String? str) {
  TextEditingController _id = TextEditingController();
  return Container(
    child: Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ID",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.name,
            controller: _id,
            decoration: InputDecoration(
                hintText: "Id",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          SizedBox(height: 20),
          OutlinedButton(
              onPressed: () {
                if (str == _id.text) {
                } else {
                  print(
                      "this session is not created by and u r not having any rights to delete");
                }
              },
              child: Text("submit"))
        ],
      ),
    ),
  );
}
