import 'package:bloc_pattarn/timer_app/bloc/bloc.dart';
import 'package:bloc_pattarn/timer_app/bloc/states.dart';
import 'package:bloc_pattarn/timer_app/components/action_buttons.dart';
import 'package:bloc_pattarn/timer_app/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTimer extends StatelessWidget {
  const HomeTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Timer App'),
      ),
      body: Stack(
        children: [
          const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      final String minutesSection = ((state.duration / 60) % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      final String secondsSection = (state.duration % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      return Text(
                        '$minutesSection:$secondsSection',
                        style: const TextStyle(
                            fontSize: 65, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<TimerBloc, TimerState>(
                buildWhen: (previousState, currentState) =>
                    currentState.runtimeType != previousState.runtimeType,
                builder: (context, state) {
                 return const ActionButtons();
                } ),
            ],
          )
        ],
      ),
    );
  }
}
