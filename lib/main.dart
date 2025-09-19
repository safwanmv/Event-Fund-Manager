import 'package:expense_tracker/db/Category_db/category_db.dart';
import 'package:expense_tracker/db/Users_db/users_db.dart';
import 'package:expense_tracker/db/transaction_db/transaction_db.dart';
import 'package:expense_tracker/models/Users/user_model.dart';
import 'package:expense_tracker/models/categroy/category_model.dart';
import 'package:expense_tracker/models/transaction/transaction%20_model.dart';
import 'package:expense_tracker/screens/Splash%20Screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(TransactionsModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  await TransactionDb.instance.initTransactionBox();
  await CategoryDB.instance.initCategoryBox();
  await UserDb.instance.initUserBox();

  runApp(MyApp());
}

ValueNotifier<bool> isDark = ValueNotifier(true);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 869),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ValueListenableBuilder<bool>(
        valueListenable: isDark,
        builder: (context, isDarkMode, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(0xFF63B89B),
                secondary: Color(0xFFFFD78E),
                brightness: Brightness.light,
                surface: Colors.white,
                onSurface: Colors.black,
                onSurfaceVariant: Color.fromARGB(255, 253, 238, 211),
              ),
              datePickerTheme: const DatePickerThemeData(
                backgroundColor: Colors.white, // Date picker only
                dayForegroundColor: WidgetStatePropertyAll(Colors.black),
                yearForegroundColor: WidgetStatePropertyAll(Colors.black),
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

              datePickerTheme: DatePickerThemeData(
                backgroundColor: Color(0xFF63B89B),
                yearOverlayColor: const WidgetStatePropertyAll(
                  Color.fromARGB(255, 0, 0, 0),
                ),
                dayForegroundColor: const WidgetStatePropertyAll(
                  Color.fromARGB(255, 0, 0, 0),
                ),
                yearForegroundColor: const WidgetStatePropertyAll(
                  Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              textTheme: ThemeData.dark().textTheme.apply(
                bodyColor: Colors.white,
              ),
            ),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
