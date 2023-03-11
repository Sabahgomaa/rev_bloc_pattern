import 'package:bloc/bloc.dart';
import 'package:bloc_pattarn/posts/bloc/events.dart';
import 'package:bloc_pattarn/posts/bloc/states.dart';
import 'package:bloc_pattarn/posts/data/repository/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial());

  Stream<PostState> mapEventToState(PostEvent postEvent) async* {
    // ignore: unnecessary_type_check
    if (postEvent is PostEvent) {
      yield PostLoading();
      try {
        final post = await repository.getPosts();
        yield (PostLoaded(post));
      } catch (e) {
        yield PostError(e.toString());
      }
    }
  }
}
