import 'package:equatable/equatable.dart';

class Profile_State extends Equatable {
  const Profile_State({this.userName = '', this.isLoading = false});

  final String userName;
  final bool isLoading;

  Profile_State copyWith({String? userName, bool? isLoading}) {
    return Profile_State(
      userName: userName ?? this.userName,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [userName, isLoading];
}
