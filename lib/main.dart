import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pretium/screens/authentication/forgot_password/views/forgot_password_page.dart';
import 'package:pretium/screens/authentication/login/views/login_page.dart';
import 'package:pretium/screens/authentication/signup/views/signup.dart';
import 'package:pretium/screens/authentication/unlock_with_pin/views/unlock_with_pin_screen.dart';
import 'package:pretium/screens/authentication/verify_account/views/verify_account_page.dart';
import 'package:pretium/screens/home/landing_page/landing_page.dart';
import 'package:pretium/screens/splash/splash_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreenPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginPage();
            },
          ),
          GoRoute(
            path: 'signup',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpPage();
            },
          ),
          GoRoute(
            path: 'verify_account',
            builder: (BuildContext context, GoRouterState state) {
              return VerifyAccountPage();
            },
          ),
          GoRoute(
            path: 'forgot_password',
            builder: (BuildContext context, GoRouterState state) {
              return const ForgotPasswordPage();
            },
          ),
          GoRoute(
            path: 'landing_page',
            builder: (BuildContext context, GoRouterState state) {
              return const LandingPage(initialIndex: 0);
            },
          ),
          GoRoute(
            path: 'pin_unlock',
            builder: (BuildContext context, GoRouterState state) {
              return  UnlockWithPinScreen();
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(0.9)),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Pretium',
    );
  }
}


