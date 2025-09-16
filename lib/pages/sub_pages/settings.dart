import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_markt/bloc/language_cubit.dart';
import 'package:text_markt/bloc/theme_cubit.dart';
import 'package:text_markt/generated/l10n.dart';

class MySettings extends StatelessWidget {
  const MySettings({super.key});

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
          const SizedBox(height: 40),
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
                  const SizedBox(height: 17),
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
  String? _errorText;

  Future<void> _savePin(String pin) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .collection('Hidden')
        .doc('hiddenNotesPin')
        .set({'pin': pin});
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
                    const SizedBox(height: 20),
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
                          if (pin.length != 4) {
                            setModalState(() {
                              _errorText = S().pinMustBe;
                            });
                            return;
                          }

                          await _savePin(pin);
                          if (mounted) Navigator.pop(context);
                          _pinController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(S().pinSuccessfullySet),
                              backgroundColor: Colors.green,
                            ),
                          );
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
