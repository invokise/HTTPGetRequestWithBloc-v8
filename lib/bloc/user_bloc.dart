import 'package:bloc/bloc.dart';
import 'package:learn_bloc/models/user_model.dart';
import 'package:learn_bloc/services/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserLoadedEvent>(_onUserLoadingEvent);
    
    on<UserResetEvent>(_onUserResetEvent);


  }
}

void _onUserLoadingEvent(UserEvent event, Emitter<UserState> emit) async {
  emit(UserLoadingState());
  try {
    final loadedUsers = await UserRepository().getAllUsers();
    emit(UserLoadedState(user: loadedUsers));
  } catch (e) {
    emit(UserErrorState(error: e));
    emit(UserInitial());
  }
}

void _onUserResetEvent(UserEvent event, Emitter<UserState> emit) {
  emit(UserInitial());
}
