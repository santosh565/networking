import 'package:counter_with_bloc/model/post.dart';
import 'package:counter_with_bloc/repository/placeholder_repository.dart';
import 'package:rxdart/rxdart.dart';

class PlaceHolderBloc {
  factory PlaceHolderBloc() {
    return _instance;
  }
  PlaceHolderBloc._internal();
  static final PlaceHolderBloc _instance = PlaceHolderBloc._internal();

  final _repository = PlaceHolderRepository();
  final _subject = BehaviorSubject<List<Post>>();

  void getAllPosts() async {
    final response = await _repository.getAllPosts();
    var posts = response.data;
    if (posts != null) {
      _subject.sink.add(posts);
    }
    if (response.error.isNotEmpty) {
      _subject.sink.addError(response.error);
    }
  }

  ValueStream<List<Post>> get posts => _subject.stream;

  void dispose() {
    _subject.value.clear();
    _subject.close();
  }
}
