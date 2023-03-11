import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_pattarn/timer_app/bloc/events.dart';
import 'package:bloc_pattarn/timer_app/bloc/states.dart';
import 'package:bloc_pattarn/timer_app/tacker/tacker.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final int _duration = 60;
  final Ticker? _ticker;
  StreamSubscription? _tickerSubscription;

  TimerBloc(super.initialState, this._ticker);

  // TimerBloc({required Ticker ticker})
  //     : _ticker = ticker, super(null);
  TimerState get initialState => Ready(_duration);

  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is Start) {
      Start start = event;
      yield Running(start.duration);
      _tickerSubscription?.cancel();
      _tickerSubscription =
          _ticker!.tick(ticks: start.duration).listen((duration) {
        add(Tick(duration: duration));
      });
    } else if (event is Pause) {
      if (state is Running) {
        _tickerSubscription?.pause();
        yield Paused(state.duration);
      }
    } else if (event is Resume) {
      if (state is Paused) {
        _tickerSubscription?.resume();
        yield Running(state.duration);
      }
    } else if (event is Reset) {
      _tickerSubscription?.cancel();
      yield Ready(_duration);
    } else if (event is Tick) {
      Tick tick = event;
      yield tick.duration > 0 ? Running(tick.duration) : const Finished();
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
// TimerBloc(this._ticker,  {required Ticker ticker}) : super(ticker as TimerState) {
// on<CounterIncrementPressed>((event, emit) => emit(state + 1));
// on<CounterDecrementPressed>((event, emit) => emit(state - 1));
// TimerBloc({required Ticker ticker}) : _ticker = ticker, super(_ticker);
