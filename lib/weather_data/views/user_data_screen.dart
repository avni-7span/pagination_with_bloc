import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_bloc/weather_data/bloc/user_data_bloc.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UserDataBloc>().add(const UserDataFetched());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    print('_isBottom: $_isBottom');
    if (_isBottom) {
      context.read<UserDataBloc>().add(const LoadMoreData());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        context.read<UserDataBloc>().add(const UserDataFetched());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'User Data',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (context, state) {
            if (state.status == UserDataStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (state.userModel.isEmpty) {
                return const Center(child: Text('no data'));
              } else {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? state.userModel.length
                      : state.userModel.length + 1,
                  itemBuilder: (context, index) {
                    return index >= state.userModel.length
                        ? const Center(child: CircularProgressIndicator())
                        : ListTile(
                            leading: Text(index.toString()),
                            title: Text(
                              state.userModel[index].name.first,
                            ),
                          );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
