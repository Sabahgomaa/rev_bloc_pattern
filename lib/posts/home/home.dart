import 'package:bloc_pattarn/posts/bloc/bloc.dart';
import 'package:bloc_pattarn/posts/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Posts'),
      ),
      body: Center(
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const CircularProgressIndicator();
            } else if (state is PostLoaded) {
              return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, i) {
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(state.posts[i].title.toString()),
                        subtitle: Text(state.posts[i].id.toString()),
                      ),
                    );
                  });
            } else if (state is PostError) {
              return Text(state.message);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
