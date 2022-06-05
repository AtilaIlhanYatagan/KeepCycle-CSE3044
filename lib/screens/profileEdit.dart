
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/screens/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class profileEdit extends StatefulWidget {
  const profileEdit({Key? key}) : super(key: key);

  @override
  State<profileEdit> createState() => _profileEditState();
}

class _profileEditState extends State<profileEdit> {
  int weight = 0;
  int height = 0;



  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            TextField(
              controller: heightController,
              decoration: InputDecoration(
                  hintText: 'Enter your height here (Ex:180)',
                  suffixIcon: IconButton(
                    onPressed: () {
                      heightController.clear();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  border: const OutlineInputBorder(),
                  fillColor: Colors.lightBlue.shade100,
                  filled: true),
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(
                  hintText: 'Enter your weight here (Ex:80)',
                  suffixIcon: IconButton(
                    onPressed: () {
                      weightController.clear();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  border: OutlineInputBorder(),
                  fillColor: Colors.lightBlue.shade100,
                  filled: true),
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton.icon(
                      label: const Text('Save'),
                      icon: const Icon(Icons.save, color: Colors.white),
                      onPressed: //(_weightController.text.isEmpty || _heightController.text.isEmpty)  ? null :
                          () {
                        setState(() {
                          height = int.parse(heightController.text);
                          weight = int.parse(weightController.text);
                          updateUser(heightController.text,weightController.text);
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=>
                                profileScreen()));
                      }),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton.icon(
                      label: const Text('Reset'),
                      icon: const Icon(Icons.clear, color: Colors.red),
                      onPressed: //(_weightController.text.isEmpty || _heightController.text.isEmpty)  ? null :
                          () {
                        setState(() {
                          height = 0;
                          weight = 0;
                          weightController.clear();
                          heightController.clear();
                        });
                      }),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
  Future updateUser(String height,String weight) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var uid =user?.uid;
    var db = FirebaseFirestore.instance;
    final userRef = db.collection("Users").doc(uid);
    return await userRef.update({
      "height": heightController.text,
      "weight": weightController.text,
    });

  }





}
