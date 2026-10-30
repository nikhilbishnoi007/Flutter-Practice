abstract class AuthState {}

class AuthIntialState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthSuccessState extends AuthState{}

class AuthFailureState extends AuthState{
  String msg;
  AuthFailureState(this.msg);  
}