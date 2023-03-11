import 'package:bloc_pattarn/timer_app/bloc/bloc.dart';
import 'package:bloc_pattarn/timer_app/components/home.dart';
import 'package:bloc_pattarn/timer_app/tacker/tacker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Timer',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(109, 234, 255, 1),
        colorScheme: const ColorScheme.light(
          secondary: Color.fromRGBO(72, 74, 126, 1),
        ),
      ),
      home: BlocProvider<TimerBloc>(
        create: (context) => TimerBloc(ticker: Ticker()),
        child: const HomeTimer(),
      ),
    );
  }
}
