import 'package:equatable/equatable.dart';

abstract class Profile_Event extends Equatable {
  const Profile_Event();

  @override
  List<Object?> get props => [];
}

class Profile_Event_LoadUserData extends Profile_Event {
  const Profile_Event_LoadUserData();
}

class Profile_Event_SignOut extends Profile_Event {
  const Profile_Event_SignOut();
}
