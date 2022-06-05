
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/screens/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'home_screen.dart';

class pictureEdit extends StatefulWidget {
  const pictureEdit({Key? key}) : super(key: key);

  @override
  State<pictureEdit> createState() => _pictureEditState();
}

class _pictureEditState extends State<pictureEdit> {
  String url =" ";

  Future updatePicture(String urll) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var uid =user?.uid;
    var db = FirebaseFirestore.instance;
    final userRef = db.collection("Users").doc(uid);
    return await userRef.update({
      "url": urll,
    });

  }
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;
      final FirebaseAuth auth = FirebaseAuth.instance;
      var user = auth.currentUser;
      var uid =user?.uid;
      final ref = FirebaseStorage.instance.ref().child("userImages").child(uid! +".jpeg");
      final imageTemp = File(image.path);
      await ref.putFile(imageTemp);
      url = await ref.getDownloadURL() ;
      updatePicture(url);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }
  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;
      final FirebaseAuth auth = FirebaseAuth.instance;
      var user = auth.currentUser;
      var uid =user?.uid;
      final ref = FirebaseStorage.instance.ref().child("userImages").child(uid! +".jpeg");

      final imageTemp = File(image.path);
      await ref.putFile(imageTemp);
      url = await ref.getDownloadURL() ;
      updatePicture(url);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.add), onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context)=>
                    profileScreen()));
          },) ,
          title: const Text("Edit Profile Picture"),
        ),
        body: Center(
          child: Column(
            children: [
              image != null ? Image.file(image!): Text("No image selected"),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                      "Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () async {
                    await pickImage();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context)=>
                            HomeScreen()));
                  }
              ),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                      "Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: ()  async {
                      await pickImageC();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context)=>
                              HomeScreen()));
                  }
              ),
              SizedBox(height: 20,),

            ],
          ),
        )
    );
  }
}
