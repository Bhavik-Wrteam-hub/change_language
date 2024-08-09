import 'package:change_language/app/appLocalization.dart';
import 'package:change_language/cubit/change_language_cubit.dart';
import 'package:change_language/data/repository/language_repo.dart';
import 'package:change_language/home_screen.dart';
import 'package:change_language/utils/appLanguage.dart';
import 'package:change_language/utils/hiveBoxKey.dart';
import 'package:change_language/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(settingsBoxKey);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLocalizationCubit(SettingsRepository()),
      child: Builder(builder: (context) {
        final currentLanguage =
            context.watch<AppLocalizationCubit>().state.language;

        return MaterialApp(
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],

          locale: currentLanguage,
          supportedLocales: appLanguages.map((appLanguage) {
            return Utils.getLocaleFromLanguageCode(
              appLanguage.languageCode,
            );
          }).toList(),
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:  const HomeScreen(),
        );
      }),
    );
  }
}
