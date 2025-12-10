import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  static const int perPage = 6;

  Completer<void>? _refreshCompleter;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<SelectUser>(_onSelectUser);
  }

  Completer<void> refreshCompleter() {
    _refreshCompleter = Completer<void>();
    return _refreshCompleter!;
  }

  void completeRefresh() {
    if (_refreshCompleter != null && !_refreshCompleter!.isCompleted) {
      _refreshCompleter!.complete();
    }
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      final currentState = state;

      if (event.refresh || currentState is UserInitial) {
        emit(UserLoadInProgress());

        final users = await userRepository.fetchUsers(
          page: 1,
          perPage: perPage,
        );

        final hasReached = users.length < perPage;

        emit(UserLoadSuccess(users: users, page: 1, hasReachedMax: hasReached));

        completeRefresh();
        return;
      }

      if (currentState is UserLoadSuccess && !currentState.hasReachedMax) {
        final nextPage = currentState.page + 1;

        final newUsers = await userRepository.fetchUsers(
          page: nextPage,
          perPage: perPage,
        );

        final hasReached = newUsers.length < perPage;

        emit(
          currentState.copyWith(
            users: List.of(currentState.users)..addAll(newUsers),
            page: nextPage,
            hasReachedMax: hasReached,
          ),
        );
      }
    } catch (e) {
      emit(UserLoadFailure(e.toString()));
      completeRefresh();
    }
  }

  void _onSelectUser(SelectUser event, Emitter<UserState> emit) {
    final currentState = state;
    if (currentState is UserLoadSuccess) {
      emit(currentState.copyWith(selectedUser: event.user));
    }
  }
}
