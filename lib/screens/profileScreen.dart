import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/screens/profileEdit.dart';
import 'package:deneme/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
@override
  void initState(){
    getData();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("User Profile"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()));
                });
              },
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileImage(),
                editPicture(),
                showName(),
                showEmail(),
                showGender(),
                showHeight(),
                showWeight(),
                Column(
                  children: [
                    editProfile(),
                  ],
                ),
                //mainMenu(),
                //logOut(),
              ],
            ),
          ),
        )
    );
  }

  Widget showGender()=>
      RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            const TextSpan(text: 'Gender: '),
            TextSpan(text: gender, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );

  Widget showHeight()=>
      RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            const TextSpan(text: 'Height: '),
            TextSpan(text: height, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );

  Widget showWeight()=>
      RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            const TextSpan(text: 'Weight: '),
            TextSpan(text: weight, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );

  // Widget mainMenu()=>
  //     ElevatedButton(
  //       child: Text("Go Main Menu"),
  //       onPressed: () {
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => HomeScreen()));
  //       },
  //     );
  // //Widget genderChoose()=>;

  Widget logOut()=>
      ElevatedButton(
        child: const Text("Logout"),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          });
        },
      );

  Widget showEmail()=>
      Row(
        children:  [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
                Icons.email
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                const TextSpan(text: 'Email: '),
                TextSpan(text: email, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      );

  Widget showName() =>
      Row(
        children:  [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
                Icons.account_circle
            ),
          ),
          RichText(
          text: TextSpan(
          style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          ),
          children: <TextSpan>[
          const TextSpan(text: 'Name: '),
          TextSpan(text: name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
          ),
          ),
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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("Edit Picture"),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const pictureEdit();
                },
              ));
            },
          ),
        ],
      );
  Widget buildProfileImage() {
    setState(() {
    });
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
          radius: 100,
          backgroundColor: Colors.grey.shade800,
          backgroundImage:  NetworkImage(url),
          ),
        ],
      );
  }


}




