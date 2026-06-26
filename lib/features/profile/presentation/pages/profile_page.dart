import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/features/profile/domain/user_profile.dart';
import 'package:text_markt/features/auth/presentation/pages/onboarding_page.dart';
import 'package:text_markt/features/profile/presentation/widgets/pin_setup.dart';
import 'package:text_markt/core/localization/language_switcher.dart';
import 'package:text_markt/core/widgets/my_button.dart';
import 'package:text_markt/core/theme/theme_switcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<UserProfile> getUserProfile() async {
    if (user == null) {
      DocumentSnapshot response = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();

      user = UserProfile.fromJson(response);
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
      body: FutureBuilder<UserProfile>(
        future: getUserProfile(),
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
              children: [
                // user image
                SizedBox(height: isTablet ? 15 : 3),
                CircleAvatar(
                  radius: isTablet ? 150 : 75,
                  backgroundImage: AssetImage(user!.image),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 5),

                // User Name and Email
                Text(
                  user!.name,
                  style: TextStyle(
                    fontSize: isTablet ? 75 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user!.email,
                  style: TextStyle(
                    fontSize: isTablet ? 45 : 16,
                    color: Colors.grey[600],
                  ),
                ),

                const Spacer(flex: 1),

                // Language Switcher
                LanguageSwitcher(),

                const SizedBox(height: 3),

                // Theme Switcher
                ThemeSwitcher(),

                const Spacer(flex: 1),

                // Pin setup
                PinSetupButton(),

                const Spacer(flex: 1),

                // sign out
                SizedBox(
                  width: double.infinity,
                  child: MyButton(
                    operation: 'out',
                    icon: Icons.logout,
                    onPressed: () async {
                      await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          final theme = Theme.of(context);
                          final isDark = theme.brightness == Brightness.dark;
                          final iconColor = isDark
                              ? Color(0xFFFF5A5F)
                              : Color(0xFFE54848);

                          return AlertDialog(
                            backgroundColor: isDark
                                ? Colors.grey[900]
                                : Colors.white,

                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: iconColor.withValues(alpha: .15),
                                  ),
                                  child: Icon(
                                    Icons.logout_rounded,
                                    color: iconColor,
                                    size: 34,
                                  ),
                                ),

                                const SizedBox(height: 15),
                                Flexible(
                                  child: Text(
                                    S.of(context).areYouSureYouWantToSignOut,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black87,
                                      fontSize: isTablet ? 50 : 16,
                                    ),
                                  ),
                                ),
                              ],
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
                                  await context.read<AuthCubit>().signOut();
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
                const Spacer(flex: 1),
              ],
            );
          }
        },
      ),
    );
  }
}
