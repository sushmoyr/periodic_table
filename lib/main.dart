import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:periodic_table/data/daily_element.dart';
import 'package:periodic_table/providers/element_providers.dart';
import 'package:periodic_table/screens/home.dart';
import 'package:periodic_table/screens/onboarding_screen.dart';
import 'package:periodic_table/screens/periodic_table_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constants.dart';

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
          colorSchemeSeed: Colors.cyan,
          scaffoldBackgroundColor: surfaceColor,
          cardColor: elevatedSurfaceColor,
          iconTheme: const IconThemeData(color: iconColor),
        ),
        home: (settingsString != null) ? HomePage() : OnBoardingScreen(),
      ),
    );
  }
}
