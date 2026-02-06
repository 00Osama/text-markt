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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: isTablet ? 100 : kToolbarHeight,
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
                // user image
                Spacer(flex: isTablet ? 3 : 1),
                CircleAvatar(
                  radius: isTablet ? 150 : 75,
                  backgroundImage: AssetImage(user!.image),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 16),

                // User Name and Email
                Text(
                  user!.name,
                  style: TextStyle(
                    fontSize: isTablet ? 75 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  user!.email,
                  style: TextStyle(
                    fontSize: isTablet ? 45 : 16,
                    color: Colors.grey[600],
                  ),
                ),

                // settings
                const Spacer(flex: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MySettings()),
                        );
                      },
                      buttonText: S.of(context).settings,
                      icon: (Icons.settings),
                    ),
                  ),
                ),

                // sign out
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: MyButton(
                    icon: Icons.logout,
                    onPressed: () async {
                      await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          final theme = Theme.of(context); // جلب Theme الحالي
                          final isDark = theme.brightness == Brightness.dark;

                          return AlertDialog(
                            backgroundColor: isDark
                                ? Colors.grey[900]
                                : Colors.white,
                            title: Text(
                              S.of(context).signOut,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 35 : 16,
                              ),
                            ),
                            content: Text(
                              S.of(context).areYouSureYouWantToSignOut,
                              style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black87,
                                fontSize: isTablet ? 50 : 16,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.blue[200]
                                        : Colors.blue,
                                    fontSize: isTablet ? 35 : 16,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await AuthService().signOut();
                                  Navigator.of(context).pop();

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
                                        ? Colors.red[300]
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isTablet ? 35 : 16,
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
                const Spacer(flex: 8),
              ],
            );
          }
        },
      ),
    );
  }
}
