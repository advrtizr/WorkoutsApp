import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:workout_app/bloc/exercise_list_bloc.dart';
import 'package:workout_app/model/workout.dart';
import 'package:workout_app/repository/exercise_list_repository.dart';
import 'package:workout_app/repository/workout_list_repository.dart';
import 'package:workout_app/ui/screen/exercise_creation_screen.dart';
import 'package:workout_app/ui/screen/host_screen.dart';
import 'package:workout_app/ui/screen/workout_creation_screen.dart';

import 'bloc/workout_bloc.dart';
import 'bloc/workout_list_bloc.dart';
import 'ui/screen/authorization_screen.dart';
import 'utils/app_localizations.dart';
import 'utils/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WorkoutListBloc(WorkoutListRepository()),
        ),
        BlocProvider(
          create: (context) => ExerciseListBloc(ExerciseListRepository()),
        ),
        BlocProvider(
          create: (context) => WorkoutBloc(Workout()),
        ),
      ],
      child: MaterialApp(
        title: 'Workout',
        debugShowCheckedModeBanner: false,
        theme: Themes.basicTheme(),
        initialRoute: HostScreen.id,
        routes: {
          AuthorizationScreen.id: (context) => AuthorizationScreen(),
          HostScreen.id: (context) => HostScreen(),
          ExerciseCreationScreen.id: (context) => ExerciseCreationScreen(),
          WorkoutCreationScreen.id: (context) => WorkoutCreationScreen(),
        },
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ru', 'RU'),
        ],
      ),
    );
  }
}
