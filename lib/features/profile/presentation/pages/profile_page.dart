import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/core/helpers/responsive.dart';
import 'package:text_markt/core/routing/app_router.dart';
import 'package:text_markt/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:text_markt/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/features/profile/presentation/widgets/pin_setup.dart';
import 'package:text_markt/core/localization/language_switcher.dart';
import 'package:text_markt/core/widgets/my_button.dart';
import 'package:text_markt/core/theme/theme_switcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);

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
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: const Color.fromARGB(255, 67, 143, 224),
                size: 90,
              ),
            );
          }

          if (state is ProfileFail) {
            return Center(
              child: Text(
                S.of(context).error,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          if (state is ProfileLoaded) {
            final userProfile = state.userProfile;

            return Column(
              children: [
                // user image
                SizedBox(height: isTablet ? 15 : 3),
                CircleAvatar(
                  radius: isTablet ? 110 : 75,
                  backgroundImage: AssetImage(userProfile.image),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 5),

                // User Name and Email
                Text(
                  userProfile.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isTablet ? 32 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userProfile.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 16,
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
                                      fontSize: isTablet ? 20 : 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  context.pop(false);
                                },
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.blue[200]
                                        : Colors.blue,
                                    fontSize: isTablet ? 18 : 16,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await context.read<AuthCubit>().signOut();
                                  context.pop();
                                  context.go(AppRoutes.onboarding);
                                },
                                child: Text(
                                  S.of(context).signOut,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.red[300]
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isTablet ? 18 : 16,
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

          return const SizedBox();
        },
      ),
    );
  }
}
