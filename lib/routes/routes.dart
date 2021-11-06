import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../splash/splash.dart';
import '../auth/auth.dart';
import '../login/login.dart';

class Routes {
  Route onGenerateRoute(RouteSettings onRoute) {
    switch (onRoute.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );

      case '/loginView':
        return MaterialPageRoute(
          builder: (_) => RepositoryProvider(
            create: (context) => AuthRepository(),
            child: LoginView(),
          ),
        );

      default:
        return errorRoute();
    }
  }

  Route errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Route Error'),
        ),
      );
    });
  }
}
