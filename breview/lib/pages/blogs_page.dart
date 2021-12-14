import 'package:breview/services/crud.dart';
import 'package:breview/util/Constants.dart';
import 'package:breview/widgets/BlogsProfileWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BlogsPage extends StatefulWidget {
  BlogsPage({Key key}) : super(key: key);

  @override
  _BlogsPageState createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  CrudMethods crudMethods = new CrudMethods();
  final firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> getUserName() async {
    final CollectionReference users = firestore.collection('UserNames');
    final String uid = auth.currentUser.uid;
    final result = await users.doc(uid).get();
    return result.doc.data()['displayName'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: Constants.SECONDARY_COLOR,
        elevation: 8,
        child: Icon(
          Icons.create_rounded,
          color: Colors.black,
          size: 24,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x3A000000),
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            Constants.WELCOME,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FutureBuilder(
                            future: getUserName(),
                            builder: (_ , AsyncSnapshot<String> snapshot){

                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center( child: CircularProgressIndicator());
                              }
                              return Text(snapshot.data);
                            },
                          ),
                          // Padding(
                          //   padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          //   child: Text(
                          //     "Abin",
                          //     style: TextStyle(
                          //       fontFamily: 'Poppins',
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              Constants.LATEST_PICKS,
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF8B97A2),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: crudMethods.getData("blogs"),
                builder: (context, AsyncSnapshot<dynamic> snap) {
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        StreamBuilder(
                            stream: snap.data,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      return BlogsProfileWidget(
                                          profilePictureUrl: snapshot.data
                                              .docs[index]['ProfilePictureUrl'],
                                          username: snapshot.data.docs[index]
                                              ['username'],
                                          image: snapshot.data.docs[index]
                                              ['image'],
                                          likes: snapshot
                                              .data.docs[index]['likes']
                                              .toString());
                                    });
                              } else {
                                return Container(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator());
                              }
                            }),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
