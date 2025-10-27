import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/bloc/language_cubit.dart';
import 'package:text_markt/bloc/theme_cubit.dart';
import 'package:text_markt/generated/l10n.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          S.of(context).settings,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
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
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          ButtonSegment(
                            value: ThemeState.light,
                            label: Text(
                              S.of(context).lightMode,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          ButtonSegment(
                            value: ThemeState.system,
                            label: Text(
                              S.of(context).systemMode,
                              style: Theme.of(context).textTheme.bodySmall,
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
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          ButtonSegment(
                            value: LanguageState.english,
                            label: Text(
                              S.of(context).english,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          ButtonSegment(
                            value: LanguageState.french,
                            label: Text(
                              S.of(context).french,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                        selected: {state},
                        onSelectionChanged: (Set<LanguageState> selected) {
                          if (selected.isNotEmpty) {
                            context.read<LanguageCubit>().setLanguage(
                              selected.first,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    S.of(context).hiddenNotesPin,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const PinSetupButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PinSetupButton extends StatefulWidget {
  const PinSetupButton({super.key});

  @override
  State<PinSetupButton> createState() => _PinSetupButtonState();
}

class _PinSetupButtonState extends State<PinSetupButton> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _errorText;
  String? passwordErrorText;

  Future<void> _savePin(String pin) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .collection('Hidden')
          .doc('hiddenNotesPin')
          .set({'pin': pin});
      if (mounted) Navigator.pop(context);
    } on Exception {
      if (mounted) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(S().pinError, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (mounted) Navigator.pop(context);
    _pinController.clear();
    passwordController.clear();
  }

  void _showPinBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.grey[200],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S().setPin,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),

                    // حقل إدخال الـ PIN
                    TextField(
                      controller: _pinController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 4,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: S().Enter4DigitsPIN,
                        errorText: _errorText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (_) {
                        setModalState(() => _errorText = null);
                      },
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        errorText: passwordErrorText,
                        hintText: S().password,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              S().signOutAndReset,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.yellow[700],
                          ),
                        );
                      },
                      child: Text(
                        S().forgetPassword,
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),

                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? WidgetStateProperty.all(Colors.grey[800])
                              : WidgetStateProperty.all(Colors.grey[300]),
                        ),
                        onPressed: () async {
                          final pin = _pinController.text.trim();
                          final password = passwordController.text.trim();

                          if (pin.length != 4) {
                            setModalState(() {
                              _errorText = S().pinMustBe;
                            });
                          }

                          if (passwordController.text.isEmpty) {
                            setModalState(() {
                              passwordErrorText = S().thisFieldIsRequired;
                            });
                          }

                          if (passwordController.text.trim().isNotEmpty) {
                            setModalState(() {
                              passwordErrorText = null;
                            });
                          }

                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null ||
                              passwordController.text.isEmpty ||
                              pin.length != 4) {
                            return;
                          }
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Center(
                                child: LoadingAnimationWidget.threeRotatingDots(
                                  color: const Color.fromARGB(
                                    255,
                                    67,
                                    143,
                                    224,
                                  ),
                                  size: 90,
                                ),
                              );
                            },
                          );
                          try {
                            final cred = EmailAuthProvider.credential(
                              email: user.email!,
                              password: password,
                            );
                            await user.reauthenticateWithCredential(cred);
                          } on FirebaseAuthException {
                            setModalState(() {
                              passwordErrorText = S().wrongPassword;
                            });
                            if (mounted) {
                              Navigator.pop(context);
                            }
                            return;
                          }
                          await _savePin(pin);
                        },
                        child: Text(S().Done),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _showPinBottomSheet,
        child: Text(
          S().setYourPin,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
