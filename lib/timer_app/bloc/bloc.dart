import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_pattarn/timer_app/bloc/events.dart';
import 'package:bloc_pattarn/timer_app/bloc/states.dart';
import 'package:bloc_pattarn/timer_app/tacker/tacker.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;
  final Ticker _ticker;
  StreamSubscription? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }

  // TimerState get initialState => Ready(_duration);
  // // TimerBloc({required Ticker ticker})
  // //     : _ticker = ticker, super(null);

  // Stream<TimerState> mapEventToState(TimerEvent event) async* {
  //   if (event is Start) {
  //     Start start = event;
  //     yield Running(start.duration);
  //     _tickerSubscription?.cancel();
  //     _tickerSubscription =
  //         _ticker!.tick(ticks: start.duration).listen((duration) {
  //       add(Tick(duration: duration));
  //     });
  //   } else if (event is Pause) {
  //     if (state is Running) {
  //       _tickerSubscription?.pause();
  //       yield Paused(state.duration);
  //     }
  //   } else if (event is Resume) {
  //     if (state is Paused) {
  //       _tickerSubscription?.resume();
  //       yield Running(state.duration);
  //     }
  //   } else if (event is Reset) {
  //     _tickerSubscription?.cancel();
  //     yield Ready(_duration);
  //   } else if (event is Tick) {
  //     Tick tick = event;
  //     yield tick.duration > 0 ? Running(tick.duration) : const Finished();
  //   }
  // }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  FutureOr<void> _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : const TimerRunComplete());
  }

  FutureOr<void> _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  FutureOr<void> _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  FutureOr<void> _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }
}
// TimerBloc(this._ticker,  {required Ticker ticker}) : super(ticker as TimerState) {
// on<CounterIncrementPressed>((event, emit) => emit(state + 1));
// on<CounterDecrementPressed>((event, emit) => emit(state - 1));
// TimerBloc({required Ticker ticker}) : _ticker = ticker, super(_ticker);
