// import 'package:flutter/material.dart';
// import 'screens/root_app.dart';
// import 'theme/color.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Booking haven',
//       theme: ThemeData(
//         primaryColor: AppColor.primary,
//       ),
//       home: const RootApp(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:booking_haven/screens/auth/login_screen.dart';
import 'package:booking_haven/screens/root_app.dart';
import 'package:booking_haven/services/auth_service.dart';
import 'package:booking_haven/theme/color.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booking Haven',
      theme: ThemeData(
        primaryColor: AppColor.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColor.secondary,
        ),
        scaffoldBackgroundColor: AppColor.appBgColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.appBarColor,
          elevation: 0,
        ),
      ),
      home: FutureBuilder<String?>(
        future: authService.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final hasToken = snapshot.hasData && snapshot.data != null;
          return hasToken ? const RootApp() : const LoginScreen();
        },
      ),
      routes: {
        '/home': (context) => const RootApp(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
