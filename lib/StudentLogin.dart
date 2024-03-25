
import 'package:autodice/authentication_service.dart';
import 'package:autodice/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SignInPage.dart ';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autodice/main.dart';
import 'package:flutter/material.dart';
import 'Teacherlogin.dart';
import 'StudentLogin.dart';
class StudentLogin extends StatefulWidget {
String? scourse;
StudentLogin({required this.scourse});
String? szor;

@override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {

  

  disablecapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }    
 getUser() async{
    print(widget.scourse);
     DocumentSnapshot dsa = await FirebaseFirestore.instance
              .collection("users")
              .doc("${widget.scourse}")
              .get();

    final subrole=dsa.get('role').toString().toLowerCase();
     final studentsc=dsa.get('courseName').toString().toLowerCase().split(" ").join() +"${subrole}";
setState(() {
  widget.szor=studentsc;
  
});
   
   
   }          

  void initState() {
    super.initState();
    disablecapture();
    getUser();
                  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
         backgroundColor: Color.fromARGB(255, 161, 82, 235),
        // title: Text("Search PDF"),
        // actions:<Widget> [IconButton(onPressed:(){showSearch(context: context, delegate: DataSearch());}, icon:Icon(Icons.search))],
        title: Text("Study Content"),
        actions:<Widget> [InkWell(onTap:(){

         
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (MyApp())));
context.read<AuthenticationService>().signOut();

        },child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text("Sign Out",
),
        ),)]
      ),
    
      body: Container(


        color:Color.fromARGB(20, 138, 62, 138),
        child: SafeArea(
          
            
                child: StreamBuilder(
                  stream:   FirebaseFirestore.instance.collection("${widget.szor}").orderBy("num").snapshots(),
     
    
                 
                        
                      
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

             
                    if (snapshot.hasData) {
                      return ListView.builder(
                        
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, i) {
                            QueryDocumentSnapshot x = snapshot.data!.docs[i];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            View(url: x['fileUrl'])));
                              },
                              child: Column(  

                                children: [
                                Container(
                         
                                  child:  Row(

                                    children: [
                                       
                                      Container(
                                          
                                        width: 50.0,
                                        height: 48.0,
                                        decoration: BoxDecoration(
                                          
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/pdf.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Container(

                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 196, 196, 196),
                                              width: 1.0,
                                            ),
                                          ),
                                         
                                        ),
                                          margin: const EdgeInsets.only(
                                              top: 20.0, bottom: 30.0),
                                          
                                            width:250,
                                              child: Text(x["num"]))
                                    ],
                                  ) )
                               
                                ],
                              ),
                            );
                      }
                      );
                         
                    }
                   else {
                      return Center(
                        child:CircularProgressIndicator()
                
                      
                      
  
                        
                      
                      
                    );
               }
                }),
              ),
      )
              
         // use it
       
    );
  }
}

class View extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  final url;

  View({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pdf-viewer"),
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }

}


class studentButton extends StatelessWidget {
  final VoidCallback eventsHandlerstudent;

  studentButton(this.eventsHandlerstudent);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 50.0,


        child: ElevatedButton(



          style: ElevatedButton.styleFrom(
shape: StadiumBorder(),
    primary: Color.fromARGB(255, 138, 99, 230), // background
   
  ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthenticationWrapper()),

              
            );
          },
        
          child: Ink(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Color.fromARGB(255, 199, 94, 199), Color.fromARGB(255, 230, 59, 139)],
            //       begin: Alignment.centerLeft,
            //       end: Alignment.centerRight,
            //     ),
            //     borderRadius: BorderRadius.circular(70.0)
            //     ),
            child: Container(
          
             
              alignment: Alignment.center,
              child: Text(
                "Login",
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



      
class AuthenticationWrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
  
    return SignInPage( );


  }
}























// class DataSearch extends SearchDelegate<String>{

//   final pdfs=[];
//   final recentPdf=[];
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return[IconButton(onPressed: (){
//       query=" ";
//     }, icon:Icon(Icons.clear))];
//     throw UnimplementedError();
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {

//     // TODO: implement buildLeading
//     return IconButton( icon: AnimatedIcon(icon:AnimatedIcons.menu_arrow,progress:transitionAnimation,  ),onPressed: (){
// close(context,'null' );


//     });
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
   
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     final suggestionList=query.isEmpty?recentPdf:pdfs.where((p) => p.startsWith(query)).toList();
//     return ListView.builder(itemBuilder: (context, index) =>ListTile(
//       onTap:(){showResults(context);} ,
      
//       leading: Icon(Icons.document_scanner),
//     title: RichText(text:TextSpan(text:suggestionList[index].substering(0,query.length),style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold)
    
//     ,children: [
//       TextSpan(text:suggestionList[index].substring(query.length),style:TextStyle(color: Colors.grey))]
//     )),
  
    
//     ),  itemCount:suggestionList.length);
//     throw UnimplementedError();
//   }
// }