import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/read%20data/get_user_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;

  //document id

  List <String> docIDs = [];

  //get ids

  Future getDocId() async{
    await FirebaseFirestore.instance.
    collection('users')
    .orderBy('age', descending: true)
        .get()
        .then(
            (snapshot) =>
    snapshot.docs.forEach(
            (document) {
      print(document.reference);
      docIDs.add(document.reference.id);
    }
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text(user.email!,
        style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.black,
        actions: [
          GestureDetector
            (
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
              child: Icon(Icons.logout))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //LIST VIEW OF USERS
            Expanded(
                child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot){
                    return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: GetUserName(documentId: docIDs[index],),
                            tileColor: Colors.grey[200],
                          ),
                        );
                      },
                    );
                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}
