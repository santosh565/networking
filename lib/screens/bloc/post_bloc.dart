import 'package:bloc/bloc.dart';
import 'package:counter_with_bloc/model/post.dart';
import 'package:counter_with_bloc/repository/placeholder_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final _repository = PlaceHolderRepository();

  PostBloc() : super(const PostState()) {
    on<PostFetched>(_onPostFetched);
  }

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _repository.fetchPosts();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            posts: posts,
            hasReachedMax: false,
            error :null,
          ),
        );
      }
      final posts = await _repository.fetchPosts(state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: PostStatus.success,
                posts: List.of(state.posts)..addAll(posts),
                hasReachedMax: false,
                error :null,
              
              ),
            );
    } catch (error) {
      emit(state.copyWith(status: PostStatus.failure, error: error.toString()));
    }
  }
}
