
import 'dart:math';
import 'package:autodice/authentication_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class Teacherlogin extends StatefulWidget {
 String? scourse;
Teacherlogin({required this.scourse});
  @override
  State<Teacherlogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<Teacherlogin> {

  disablecapture() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void initState() {
    super.initState();
    disablecapture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Search PDF"),
        // actions:<Widget> [IconButton(onPressed:(){showSearch(context: context, delegate: DataSearch());}, icon:Icon(Icons.search))],
        title: Text("Teachers Content"),
        actions:<Widget> [InkWell(onTap:(){

context.read<AuthenticationService>().signOut();

        },child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text("Sign Out",
),
        ),)]
      ),
    
      body: SafeArea(
          
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("${widget.scourse}-Teacher").orderBy("num").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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