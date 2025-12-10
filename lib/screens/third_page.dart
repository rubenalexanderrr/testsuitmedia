import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmediatest/utils/my_app_bar.dart';
import '../blocs/user_bloc/user_bloc.dart';
import '../blocs/user_bloc/user_event.dart';
import '../blocs/user_bloc/user_state.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final _scrollController = ScrollController();
  late UserBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<UserBloc>();
    _bloc.add(FetchUsers(refresh: true));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _bloc.add(FetchUsers());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final threshold = 200;
    return _scrollController.position.extentAfter < threshold;
  }

  Future<void> _onRefresh() async {
    final completer = _bloc.refreshCompleter();
    _bloc.add(FetchUsers(refresh: true));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: 'Third Screen'),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadSuccess) {
            _bloc.completeRefresh();
          }
        },
        builder: (context, state) {
          if (state is UserLoadInProgress || state is UserInitial) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is UserLoadFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is UserLoadSuccess) {
            final users = state.users;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? users.length
                      : users.length + 1,
                  separatorBuilder: (_, __) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    if (index >= users.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final user = users[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: ListTile(
                        minTileHeight: 80,
                        leading: SizedBox(
                          width: 48,
                          height: 48,
                          child: ClipOval(
                            child: Image.network(
                              user.avatar,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        title: Text(
                          user.fullName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          user.email,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                        onTap: () {
                          context.read<UserBloc>().add(SelectUser(user));
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
