import 'package:bloc_pattarn/counter_app/counter_bloc/bloc.dart';
import 'package:bloc_pattarn/counter_app/counter_bloc/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Counter App'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                counterBloc.add(CounterDecrementPressed());
              },
              icon: const Icon(
                Icons.remove,
              ),
            ),
            BlocBuilder<CounterBloc, int>(builder: (context, state) {
              return Text('$state');
            }),
            IconButton(
              onPressed: () {
                counterBloc.add(CounterIncrementPressed());
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
