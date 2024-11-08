import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:textmarkt/auth/services/auth_service.dart';
import 'package:textmarkt/globals.dart';
import 'package:textmarkt/models/user.dart';
import 'package:textmarkt/pages/sub_pages/onboarding.dart';
import 'package:textmarkt/widgets/my_button.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<UserInfoData> getUserData() async {
    if (user == null) {
      DocumentSnapshot response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();

      user = UserInfoData.fromJson(response);
      return user!;
    }
    return user!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F6),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F2F6),
        surfaceTintColor: const Color(0xffF2F2F6),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.07,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<UserInfoData>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: const Color.fromARGB(255, 67, 143, 224),
                size: 90,
              ),
            );
          } else {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),

                  CircleAvatar(
                    radius: 50, // Larger size for the avatar
                    backgroundImage: AssetImage(user!.image),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(height: 16),

                  // User Name
                  Text(
                    user!.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    user!.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Spacer(flex: 8),

                  SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      onPressed: () async {
                        await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Sign Out'),
                              content: const Text(
                                'Are you sure you want to sign out ?!',
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Perform sign-out
                                    await AuthService().signOut();
                                    Navigator.of(context).pop();

                                    // Navigate to the Onboarding screen
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Onboarding(),
                                      ),
                                    );
                                  },
                                  child: const Text('Sign Out'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      buttonText: 'Sign out',
                    ),
                  ),
                  const Spacer(flex: 5),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
