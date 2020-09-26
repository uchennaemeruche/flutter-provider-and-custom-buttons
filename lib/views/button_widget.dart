import 'package:flutter/material.dart';
import 'package:flutter_check_app/widgets/animated_button.dart';
import 'package:flutter_check_app/widgets/swipe_button.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child:Column(
       
        children: [
           SizedBox(height: 80.0),
           ButtonAnimation(
        primaryColor: Color.fromRGBO(57, 92, 249,1),
        darkPrimaryColor: Color.fromRGBO(44, 78, 233, 1),
      ),
      SizedBox(height: 20.0),
           ButtonAnimation(
        primaryColor: Colors.yellow[700],
        darkPrimaryColor: Colors.yellow[800],
      ),
      SizedBox(height: 20.0),
           ButtonAnimation(
        primaryColor: Colors.green[400],
        darkPrimaryColor: Colors.green[600],
      ),
      SizedBox(height: 50.0),
      SwipeButton(),
       ],
      )
    ),
    );
  }
}