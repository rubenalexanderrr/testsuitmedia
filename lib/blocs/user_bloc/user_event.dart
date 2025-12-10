import 'package:equatable/equatable.dart';
import '../../models/user_model.dart';


abstract class UserEvent extends Equatable {
@override
List<Object?> get props => [];
}


class FetchUsers extends UserEvent {
final bool refresh;
FetchUsers({this.refresh = false});
@override
List<Object?> get props => [refresh];
}


class SelectUser extends UserEvent {
final UserModel user;
SelectUser(this.user);
@override
List<Object?> get props => [user];
}