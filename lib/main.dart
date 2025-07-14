import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:textmarkt/auth/services/auth_gate.dart';
import 'package:textmarkt/bloc/event_cubit.dart';
import 'package:textmarkt/bloc/note_cubit.dart';
import 'package:textmarkt/core/theme.dart';
import 'package:textmarkt/firebase_options.dart';
import 'package:textmarkt/search/search_cubit.dart';
import 'package:textmarkt/services/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Notifications.initializeNotifications();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteCubit>(
          create: (context) => NoteCubit(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(),
        ),
        BlocProvider<EventCubit>(
          create: (context) => EventCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged.map(
              (list) => list.isNotEmpty ? list.last : ConnectivityResult.none),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
              return const AuthGate();
            } else {
              return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/app/noInternet.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 60),
                      Text(
                        'no internet connection',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
