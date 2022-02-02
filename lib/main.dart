import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/placeholder_bloc.dart';
import 'cubit/counter_cubit.dart';
import 'response/get_all_post_response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final PlaceHolderBloc _placeHolderBloc;

  @override
  void initState() {
    super.initState();
    _placeHolderBloc = PlaceHolderBloc()..getAllPosts();
  }

  @override
  void dispose() {
    _placeHolderBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('MyHomePage build');
    return Scaffold(
      appBar: AppBar(
        title: const Text("widget.title"),
      ),
      body: StreamBuilder<List<Post>>(
        stream: _placeHolderBloc.posts,
        builder: (context, snapshot) {
          var posts = snapshot.data;
          if (posts == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (posts.isEmpty) {
            return const Center(child: Text("No post Available"));
          }
          if (snapshot.hasError) {
            var error = snapshot.error;
            return Center(child: Text(error.toString()));
          }
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              var post = posts[index];
              return Card(
                child: ListTile(
                  onTap: () {},
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  leading: Text(
                    post.userId.toString(),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _placeHolderBloc.getAllPosts();
              // context.read<CounterCubit>().increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              _placeHolderBloc.dispose();

              // context.read<CounterCubit>().decrement();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint('CounterText build');
    return BlocBuilder<CounterCubit, int>(
      builder: (context, state) {
        return Text('$state');
      },
    );
  }
}
