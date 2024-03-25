
import 'package:autodice/authentication_service.dart';
import 'package:autodice/registerbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import './studentButton.dart';
import 'StudentLogin.dart';
import 'SignInPage.dart';
import 'registration.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/gestures.dart';

void main()  async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
await Hive.initFlutter();

  runApp(MyApp());
}


void _printw() {
  print("Hello");
}
class MyApp extends StatelessWidget {
  
  Widget build(BuildContext context) {
     precacheImage(AssetImage("assets/images/sbyte.png"), context);
    return MultiProvider(
    providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
          StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null),
      ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Raleway'),
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 56, 6, 104),
                title: Text('SmartByte Computer Education'),
               ),
            body: Container(
            
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(156, 199, 167, 245),),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/sbyte.png',
                            height: 150, width: 400),
                  
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center  ,
                          children: [
                
                            studentButton(_printw),
                            Registerbutton(_printw),
                          ],
                        ),
    
                        Container( child:Lottie.asset('assets/lottie/menace.json'),height: 240,)
                      
                     
                      ],
                    ),
                  
                  ),
                  
                ),
               
              ),
            ))
            
            ),
            
            );

  }
}


// class AuthenticationWrapper extends StatelessWidget {
// //   String? req;
// // AuthenticationWrapper({required this.req});
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User?>();

//     return SignInPage();
  
// }
// }