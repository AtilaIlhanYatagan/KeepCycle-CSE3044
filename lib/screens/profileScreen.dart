import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/screens/profileEdit.dart';
import 'package:deneme/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:deneme/screens/home_screen.dart';
import 'pictureEdit.dart';

class profileScreen extends StatefulWidget {

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  String name = " ";
  String email = " ";
  String gender = " ";
  String height = " ";
  String weight = " ";
  String url = " ";
  void getData() async{
    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance.collection("Users").doc(user?.uid).get();
    setState(() {
      name = vari.data()!["name"];
      email = vari.data()!["email"];
      gender = vari.data()!["gender"];
      height = vari.data()!["height"];
      weight = vari.data()!["weight"];
      url = vari.data()!["url"];
    });

  }
void initState(){
    getData();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("User Profile"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildProfileImage(),
              showName(),
              showEmail(),
              showGender(),
              showHeight(),
              showWeight(),
              editProfile(),
              editPicture(),
              mainMenu(),
              logOut(),
            ],
          ),
        )
    );
  }

  Widget showGender()=>
      Text("Gender: "+ gender,);
  Widget showHeight()=>
      Text("Height: "+ height,);
  Widget showWeight()=>
      Text("Weight: "+ weight );
  Widget mainMenu()=>
      ElevatedButton(
        child: Text("Go Main Menu"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );
  //Widget genderChoose()=>;
  Widget logOut()=>
      ElevatedButton(
        child: Text("Logout"),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          });
        },
      );
  Widget showEmail()=>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Icon(
              Icons.email
          ),
          Text("Email: "+ email,)
        ],
      );
  Widget showName() =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Icon(
              Icons.account_circle
          ),
          Text("Name: "+name,)
        ],
      );
  Widget editProfile() =>
      ElevatedButton(
        child: const Text("Edit Profile"),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const profileEdit();
            },
          ));
        },
      );
  Widget editPicture() =>
      ElevatedButton(
        child: const Text("Edit Picture"),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const pictureEdit();
            },
          ));
        },
      );
  Widget buildProfileImage() {
    setState(() {
    });
    return
      CircleAvatar(
    radius: 100,
    backgroundColor: Colors.grey.shade800,
    backgroundImage:  NetworkImage(url),
  );}


}




