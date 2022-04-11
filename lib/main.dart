import 'package:flutter/material.dart';
import 'package:periodic_table/providers/element_providers.dart';
import 'package:periodic_table/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? settingsString;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  settingsString = preferences.getString(AppSettings.settingsKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ElementList>(
          create: (context) => ElementList(),
        ),
        ChangeNotifierProvider<ElementSearch>(
          create: (context) => ElementSearch(),
        ),
        ChangeNotifierProvider<AppSettings>(
          create: (context) => AppSettings(),
        ),
      ],
      child: MaterialApp(
        title: 'Periodic Table',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.blue,
          scaffoldBackgroundColor: Color(0xFF070706),
        ),
        home: (settingsString != null) ? HomeScreen() : OnBoardingScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
