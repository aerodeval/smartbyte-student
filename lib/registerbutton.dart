import 'package:autodice/main.dart';
import 'package:autodice/registration.dart';
import 'package:flutter/material.dart';
import 'Teacherlogin.dart';
import 'StudentLogin.dart';

class Registerbutton extends StatelessWidget {
  final VoidCallback eventsHandlerregister;

  Registerbutton(this.eventsHandlerregister);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 50.0,
      margin: EdgeInsets.all(10),

        child: ElevatedButton(
         style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
    primary: Color.fromARGB(255, 202, 60, 167), // background
   
  ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegistrationScreen()),
            );
          },
  
        
          child: Ink(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Color.fromARGB(255, 112, 189, 166), Color.fromARGB(255, 11, 204, 156)],
            //       begin: Alignment.centerLeft,
            //       end: Alignment.centerRight,
            //     ),
            //     // borderRadius: BorderRadius.circular(70.0)),
            // ),
            child: Container(
          
             
              alignment: Alignment.center,
              child: Text(
                "Register",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
   
    );
  }
}
