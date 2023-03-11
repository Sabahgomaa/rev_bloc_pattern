import 'package:bloc_pattarn/timer_app/bloc/bloc.dart';
import 'package:bloc_pattarn/timer_app/bloc/events.dart';
import 'package:bloc_pattarn/timer_app/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _mapStateToActionButtons(
        timerBloc: BlocProvider.of<TimerBloc>(context),
      ),
    );
  }

  List<Widget> _mapStateToActionButtons({required TimerBloc timerBloc}) {
    final TimerState currentState = timerBloc.state;
    if (currentState is Ready) {
      return [
        FloatingActionButton(
          child: const Icon(Icons.play_arrow),
          onPressed: () {
            timerBloc.add(Start(currentState.duration));
          },
        ),
      ];
    }
    if (currentState is Running) {
      return [
        FloatingActionButton(
          child: const Icon(Icons.pause),
          onPressed: () {
            timerBloc.add(Pause());
          },
        ),
        FloatingActionButton(
          child: const Icon(Icons.replay),
          onPressed: () {
            timerBloc.add(Reset());
          },
        )
      ];
    }
    if (currentState is Paused) {
      return [
        FloatingActionButton(
          child: const Icon(Icons.play_arrow),
          onPressed: () {
            timerBloc.add(Resume());
          },
        ),
        FloatingActionButton(
          child: const Icon(Icons.replay),
          onPressed: () {
            timerBloc.add(Reset());
          },
        )
      ];
    }
    if (currentState is Finished) {
      return [
        FloatingActionButton(
          child: const Icon(Icons.replay),
          onPressed: () {
            timerBloc.add(Reset());
          },
        )
      ];
    }
    return [];
  }
}