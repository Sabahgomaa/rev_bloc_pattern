import 'package:bloc_pattarn/timer_app/bloc/bloc.dart';
import 'package:bloc_pattarn/timer_app/bloc/events.dart';
import 'package:bloc_pattarn/timer_app/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (state is TimerInitial) ...[
                FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context.read<TimerBloc>().add(
                        TimerStarted(duration: state.duration),
                      ),
                ),
              ],
              if (state is TimerRunInProgress) ...[
                FloatingActionButton(
                    child: const Icon(Icons.pause),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerPaused())),
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],
              if (state is TimerRunPause) ...[
                FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerResumed()),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],
              if (state is TimerRunComplete) ...[
                FloatingActionButton(
                  onPressed: () => context.read<TimerBloc>().add(
                        const TimerReset(),
                      ),
                ),
              ]
            ],
          );
        });
  }
}
