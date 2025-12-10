import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';


abstract class UserState extends Equatable {
@override
List<Object?> get props => [];
}


class UserInitial extends UserState {}


class UserLoadInProgress extends UserState {}


class UserLoadSuccess extends UserState {
final List<UserModel> users;
final int page;
final bool hasReachedMax;
final UserModel? selectedUser;


UserLoadSuccess({
required this.users,
required this.page,
required this.hasReachedMax,
this.selectedUser,
});


UserLoadSuccess copyWith({
List<UserModel>? users,
int? page,
bool? hasReachedMax,
UserModel? selectedUser,
}) {
return UserLoadSuccess(
users: users ?? this.users,
page: page ?? this.page,
hasReachedMax: hasReachedMax ?? this.hasReachedMax,
selectedUser: selectedUser ?? this.selectedUser,
);
}


@override
List<Object?> get props => [users, page, hasReachedMax, selectedUser];
}


class UserLoadFailure extends UserState {
final String message;
UserLoadFailure(this.message);


@override
List<Object?> get props => [message];
}