import 'package:bloc/bloc.dart';
import 'package:bloc_pattarn/counter_app/counter_bloc/events.dart';

class CounterBloc extends Bloc<CounterEvents, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) => emit(state + 1));
    on<CounterDecrementPressed>((event, emit) => emit(state - 1));
  }

// Stream<int> mapEventToState(CounterEvents event) async* {
//   switch (event) {
//     case CounterEvents.add:
//       yield state + 1;
//       break;
//     case CounterEvents.remove:
//       yield state - 1;
//       break;
//   }
// }
}
