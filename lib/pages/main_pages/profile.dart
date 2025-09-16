import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/auth/services/auth_service.dart';
import 'package:text_markt/bloc/language_cubit.dart';
import 'package:text_markt/bloc/theme_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/globals.dart';
import 'package:text_markt/models/user.dart';
import 'package:text_markt/pages/sub_pages/onboarding.dart';
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
                const SizedBox(height: 8),

                Text(
                  user!.email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const Spacer(flex: 4),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).themeMode,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        BlocBuilder<ThemeCubit, ThemeState>(
                          builder: (context, state) {
                            return SegmentedButton<ThemeState>(
                              segments: [
                                ButtonSegment(
                                  value: ThemeState.dark,
                                  label: Text(
                                    S.of(context).darkMode,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                                ButtonSegment(
                                  value: ThemeState.light,
                                  label: Text(
                                    S.of(context).lightMode,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                                ButtonSegment(
                                  value: ThemeState.system,
                                  label: Text(
                                    S.of(context).systemMode,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                              selected: {state},
                              onSelectionChanged: (Set<ThemeState> selected) {
                                context.read<ThemeCubit>().setThemeMode(
                                  selected.first,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).language,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        BlocBuilder<LanguageCubit, LanguageState>(
                          builder: (context, state) {
                            return SegmentedButton<LanguageState>(
                              segments: [
                                ButtonSegment(
                                  value: LanguageState.arabic,
                                  label: Text(
                                    S.of(context).arabic,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                                ButtonSegment(
                                  value: LanguageState.english,
                                  label: Text(
                                    S.of(context).english,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                                ButtonSegment(
                                  value: LanguageState.french,
                                  label: Text(
                                    S.of(context).french,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                              selected: {state},
                              onSelectionChanged:
                                  (Set<LanguageState> selected) {
                                    if (selected.isNotEmpty) {
                                      context.read<LanguageCubit>().setLanguage(
                                        selected.first,
                                      );
                                    }
                                  },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 4),
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
                const Spacer(flex: 8),
              ],
            );
          }
        },
      ),
    );
  }
}
