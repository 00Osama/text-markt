import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:textmarkt/auth/pages/signin_screen.dart';
import 'package:textmarkt/auth/pages/signup_screen.dart';

class AuthTab extends StatelessWidget {
  const AuthTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SegmentedTabControl(
                  tabTextColor: Colors.black45,
                  selectedTabTextColor: Colors.white,
                  tabs: [
                    SegmentTab(
                      label: 'Sign in',
                      backgroundColor: Colors.blue.shade100,
                      color: Colors.blue.shade200,
                      selectedTextColor: Colors.black,
                      textColor: Colors.black26,
                    ),
                    SegmentTab(
                      label: 'Sign up',
                      color: Colors.blue.shade300,
                      backgroundColor: Colors.blue.shade100,
                      selectedTextColor: Colors.black,
                      textColor: Colors.black26,
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    SigninScreen(),
                    SignUpScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
