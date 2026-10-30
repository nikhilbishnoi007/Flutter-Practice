import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_managment/blocs/auth/auth_event.dart';
import 'package:state_managment/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc():super(AuthIntialState()){
    on<LoginEvent>((event, emit) async{
      emit(AuthLoadingState());
      await Future.delayed(Duration(seconds: 2));
      String email =event.email;
      String password=event.password;
      if(email.contains("@") && password.length>=8){
        emit(AuthSuccessState());
      }else{
        emit(AuthFailureState("invalid email or password"));
      }
    });
  }
}