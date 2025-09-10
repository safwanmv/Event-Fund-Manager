import 'package:expense_tracker/screens/Splash%20Screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

ValueNotifier<bool> isDark = ValueNotifier(true);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDark,
      builder: (context, isDarkMode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            // scaffoldBackgroundColor: Colors.white,
            // primaryColor: const Color(0xFF63B89B),
            // highlightColor: const Color(0xFFFFD78E),

            // textTheme: ThemeData.light().textTheme.apply(
            //   bodyColor: Colors.black,
            //   displayColor: Colors.black,
            // )
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFF63B89B),
              secondary: Color(0xFFFFD78E),
              brightness: Brightness.light,
              surface: Colors.white,
              onSurface: Colors.black,
              onSurfaceVariant:Color.fromARGB(255, 255, 249, 238),
            ),
            textTheme: ThemeData.light().textTheme.apply(
              bodyColor: Colors.black,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xFF63B89B),
              secondary: Color(0xFFFFD78E),
              surface: Colors.black,
              onSurface: Colors.white,
              onSurfaceVariant: Colors.grey[900],

              brightness: Brightness.dark,
            ),
            textTheme: ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
            ),
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const SplashScreen(),
        );
      },
    );
  }
}
