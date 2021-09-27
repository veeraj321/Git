

import 'package:flutter/material.dart';


class TextFormFieldWidget extends StatefulWidget {

  @override
  _TextFormFieldWidgetState  createState() => _TextFormFieldWidgetState();


}



class _TextFormFieldWidgetState extends State<TextFormFieldWidget>{

  @override
  Widget build(BuildContext context){
    return Theme(data: Theme.of(context).copyWith(primaryColor: Colors.blue), 
    child:Container(color:Colors.white,
    width:230,
    constraints: BoxConstraints(maxWidth: 500.0,minHeight: 25.0),child: TextField(decoration: InputDecoration(hintText: 'Please enter the session id'),),) );
  }


}