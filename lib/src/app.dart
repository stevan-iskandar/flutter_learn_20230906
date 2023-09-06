import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_learn_20230906/src/constants/env.dart';
import 'package:flutter_learn_20230906/src/screens/place_list_screen.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme setColorScheme({
  required Brightness brightness,
}) {
  Color background = const Color.fromARGB(255, 255, 255, 255);

  if (brightness == Brightness.dark) {
    background = const Color.fromARGB(255, 56, 49, 66);
  }

  return ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: const Color.fromARGB(255, 102, 6, 247),
    background: background,
  );
}

ThemeData theme({
  required Brightness brightness,
}) {
  ColorScheme colorScheme = setColorScheme(brightness: brightness);

  return ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.background,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      titleSmall: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: theme(brightness: Brightness.light),
      darkTheme: theme(brightness: Brightness.dark),
      debugShowCheckedModeBanner:
          dotenv.env[Env.debug]?.toLowerCase() == 'true',
      home: const PlaceListScreen(),
    );
  }
}
