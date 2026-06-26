import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:text_markt/features/auth/presentation/widgets/auth_gate.dart';
import 'package:text_markt/generated/l10n.dart';

class InternetConnectivity extends StatelessWidget {
  const InternetConnectivity({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged.map(
        (results) => results.isEmpty ? ConnectivityResult.none : results.first,
      ),
      builder: (context, snapshot) {
        final hasConnection =
            snapshot.data != null && snapshot.data != ConnectivityResult.none;

        if (hasConnection) {
          return const AuthGate();
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/noInternet.json',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 60),
                Text(
                  S.of(context).noInternetConnection,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
