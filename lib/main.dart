import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_finance_pro/config/app_config.dart';
import 'package:home_finance_pro/core/theme/app_theme.dart';
import 'package:home_finance_pro/presentation/pages/home/home_page.dart';
import 'package:home_finance_pro/services/database_service.dart';
import 'package:home_finance_pro/services/notification_service.dart';
import 'package:google_fonts/google_fonts.dart';

future void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initialize();
  await DatabaseService().initializeDatabase();
  await NotificationService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseService>(create: (_) => DatabaseService()),
        Provider<NotificationService>(create: (_) => NotificationService()),
      ],
      child: MaterialApp(
        title: 'HomeFinance Pro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6366F1),
            brightness: Brightness.light,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6366F1),
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(
            ThemeData.dark().textTheme,
          ),
          scaffoldBackgroundColor: const Color(0xFF121212),
        ),
        themeMode: ThemeMode.system,
        home: const HomePage(),
      ),
    );
  }
}
