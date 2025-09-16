import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/auth/services/auth_service.dart';

import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/models/user.dart';
import 'package:text_markt/pages/sub_pages/onboarding.dart';
import 'package:text_markt/pages/sub_pages/settings.dart';
import 'package:text_markt/widgets/my_button.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          S.of(context).profile,
          style: Theme.of(context).textTheme.headlineLarge,
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
            return Column(
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
                  ),
                ),
                Text(
                  user!.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: Theme.of(
                        context,
                      ).elevatedButtonTheme.style!.backgroundColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MySettings(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          S.of(context).settings,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: isDark ? Colors.white : Colors.black,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                SizedBox(
                  width: double.infinity,
                  child: MyButton(
                    onPressed: () async {
                      await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: isDark
                                ? const Color(
                                    0xFF1E2A28,
                                  ) // Dark mode background
                                : const Color.fromARGB(
                                    255,
                                    178,
                                    216,
                                    223,
                                  ), // Light mode background
                            title: Text(
                              S.of(context).signOut,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            content: Text(
                              S.of(context).areYouSureYouWantToSignOut,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
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
                                      builder: (context) => const Onboarding(),
                                    ),
                                  );
                                },
                                child: Text(
                                  S.of(context).signOut,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.redAccent
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    buttonText: S.of(context).signOut,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            );
          }
        },
      ),
    );
  }
}
