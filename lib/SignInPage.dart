import 'package:autodice/StudentLogin.dart';
import 'package:autodice/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'studentButton.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isChecked=false;
  bool pass = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late Box box1;



void initState(){

  super.initState();
  createBox();
  getdata();
}
void createBox()async{
  box1=await Hive.openBox('logindata');
  getdata();
}
void login(){
  if(isChecked){
    box1.put('email', emailController.text);
    box1.put('pass', passwordController.text);
  }
}
void getdata() async{

  if(box1.get('email')!=null){emailController.text=box1.get('email');}
  if(box1.get('pass')!=null){passwordController.text=box1.get('pass');}
  isChecked=true;
  setState(() {
    
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(110, 60, 181, 100),
      
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Text("Sign In",
                          style: GoogleFonts.montserrat(
                              fontSize: 60,
                              fontWeight: FontWeight.w700,
                              color: Colors.white))),
                ),
                SizedBox(height:50),
                Container(
                  width: 300,
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),   
                  color: Colors.white,),
               
                  child: Column(children: [
                    TextField(
                       
                      controller: emailController,
                      decoration: InputDecoration(
                     
                     
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    TextField(
                      
                    
                      obscureText: pass,
                      controller: passwordController,
                      decoration: InputDecoration(
                        
                          labelText: "Password",
                          prefixIcon: Icon(Icons.security),
                          suffixIcon: InkWell(
                              onTap: _passview, child: Icon(Icons.visibility))),
                    ),
                    ElevatedButton(
                       style: ElevatedButton.styleFrom(

    primary: Color.fromARGB(255, 117, 75, 214), ),// backgro

                      onPressed: () async{
                        context.read<AuthenticationService>().signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context
                            )
                          ;
                          login();

                          
    // String scourse=emailController.text
    //                                 .split("@")
    //                                 .join()
    //                                 .split(".in")
    //                                 .join();

                           
                                
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => StudentLogin(
                        //         scourse: emailController.text
                        //             .split("@")
                        //             .join()
                        //             .split(".in")
                        //             .join())));
                                   

                      },
                      child: Text("Sign in"),
                    ),
                  ]),
                ),Container(
                  
                 
                  
                  
                  child: Row( mainAxisAlignment: MainAxisAlignment.center,children: [Text("Remember me",style: TextStyle(color:Colors.white,fontSize: 15),),Checkbox(value: isChecked, onChanged: (value){isChecked=!isChecked;
                setState(() {
                  
                });
                
                })],)),
                Container(
                  child: Lottie.asset('assets/lottie/kidstudy.json'),
                  height: 350,
                )
              ],
            ),
          ),
        );
 
  }

  void _passview() {
    if (pass == true) {
      pass = false;
    } else {
      pass = true;
    }
    setState(() {});
  }
}
