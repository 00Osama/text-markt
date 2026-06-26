import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:text_markt/core/dependency_injection/service_locator.dart';
import 'package:text_markt/features/auth/presentation/pages/verify_email_checker.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/features/auth/presentation/pages/onboarding_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ServiceLocator.authRepository.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: const Color.fromARGB(255, 67, 143, 224),
                size: 90,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: SmartRefresher(
              enablePullDown: true,
              header: WaterDropHeader(complete: Text(S().refreshCompleted)),
              controller: refreshController,
              onRefresh: () {
                setState(() {
                  refreshController.refreshCompleted();
                });
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isTablet = constraints.maxWidth > 600;
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 32 : 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/error.png',
                            width: isTablet ? 280 : 260,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: isTablet ? 40 : 30),
                          Text(
                            S().somethingWentWrong,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return const VerifyEmailChecker();
        } else {
          return const Onboarding();
        }
      },
    );
  }
}
