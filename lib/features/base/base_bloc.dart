import 'package:bloc/bloc.dart';
import 'base_event.dart';
import 'base_state.dart';

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(super.initialState);
}
