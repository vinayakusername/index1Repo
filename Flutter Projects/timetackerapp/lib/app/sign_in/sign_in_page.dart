import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Time Tracker'),
        elevation: 4.0,
      ), 

      body: Container
      (
        color:Colors.yellow,
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>
          [
            Container
            (
              color:Colors.orange,
              child: SizedBox
              (
                width: 100,
                height: 100,
              ),
            )
          ],
        ),
      ), 
    );
  }
}