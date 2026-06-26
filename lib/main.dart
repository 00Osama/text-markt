import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_markt/core/dependency_injection/service_locator.dart';
import 'package:text_markt/features/auth/presentation/widgets/auth_gate.dart';
import 'package:text_markt/core/localization/language_cubit.dart';
import 'package:text_markt/core/theme/theme_cubit.dart';
import 'package:text_markt/core/theme/theme_model.dart';
import 'package:text_markt/firebase_options.dart';
import 'package:text_markt/generated/l10n.dart';
import 'package:text_markt/features/search/cubits/search_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ServiceLocator.setup();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ThemeCubit(sharedPreferences: prefs)..loadThemePreference(),
        ),
        BlocProvider(
          create: (_) =>
              LanguageCubit(sharedPreferences: prefs)..loadLanguagePreference(),
        ),
      ],
      child: const MyApp(),
    ),
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
        BlocProvider(create: (context) => ServiceLocator.createNoteCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => ServiceLocator.createEventCubit()),
        BlocProvider(create: (context) => ServiceLocator.createAuthCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, langState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: context.watch<LanguageCubit>().locale,
                theme: AppTheme.lightTheme(context),
                darkTheme: AppTheme.darkTheme(context),
                themeMode: context.watch<ThemeCubit>().themeMode,
                home: InternetConnectivity(),
              );
            },
          );
        },
      ),
    );
  }
}

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
