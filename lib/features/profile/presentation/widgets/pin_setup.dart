import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:text_markt/core/helpers/error_snackbar_helper.dart';
import 'package:text_markt/core/helpers/success_snackbar_helper.dart';
import 'package:text_markt/generated/l10n.dart';

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
      successSnackBar(context: context, title: S().pinSuccessfullySet);
    } on Exception {
      if (mounted) Navigator.pop(context);
      errorSnackBar(context: context, title: S().pinError);
    }
    if (mounted) Navigator.pop(context);
    _pinController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = screenWidth > 600;

    void showPinBottomSheet() {
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
                      Container(
                        width: 45,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade700
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Text(
                        S().setPin,
                        style: TextStyle(
                          fontSize: isTablet ? 50.0 : 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextField(
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        maxLength: 4,
                        textAlign: TextAlign.center,

                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: isTablet ? 50.0 : 14.0,
                          ),
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
                          hintStyle: TextStyle(
                            fontSize: isTablet ? 50.0 : 14.0,
                          ),
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
                          errorSnackBar(
                            context: context,
                            title: S().signOutAndResetPassword,
                          );
                        },
                        child: Text(
                          S().forgotPassword,
                          style: TextStyle(
                            fontSize: isTablet ? 34 : 14,
                            color: Colors.blue,
                          ),
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
                                passwordErrorText = S().fieldRequired;
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
                                  child:
                                      LoadingAnimationWidget.threeRotatingDots(
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
                          child: Text(
                            S().Done,
                            style: TextStyle(fontSize: isTablet ? 30 : 14),
                          ),
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 60 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).pinSetup,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: showPinBottomSheet,
              child: Container(
                height: isTablet ? 72 : 48,
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 14 : 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: isTablet ? 42 : 28,
                      height: isTablet ? 42 : 28,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        size: isTablet ? 24 : 16,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),

                    SizedBox(width: isTablet ? 14 : 9),

                    Text(
                      S.of(context).hiddenNotesPin,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : const Color(0xFF17383D),
                        fontSize: isTablet ? 20 : 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      height: isTablet ? 42 : 30,
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 14 : 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            S.of(context).setPin,
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const Color(0xFFB6C8CA)
                                  : const Color(0xFF64777A),
                              fontSize: isTablet ? 16 : 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(width: isTablet ? 8 : 4),

                          Icon(
                            Icons.chevron_right_rounded,
                            size: isTablet ? 20 : 16,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xFFB6C8CA)
                                : const Color(0xFF64777A),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
