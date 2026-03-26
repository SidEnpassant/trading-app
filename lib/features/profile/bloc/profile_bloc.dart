import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/di/service_locator.dart';
import 'package:trading/features/auth/bloc/auth_bloc.dart';
import 'package:trading/features/profile/data/models/account_details.dart';
import 'package:trading/features/profile/data/models/user_profile.dart';
import 'package:trading/features/profile/data/repositories/profile_repository.dart';
import 'package:trading/features/profile/bloc/profile_event.dart';
import 'package:trading/features/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository = sl<ProfileRepository>();

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<Logout>(_onLogout);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await _profileRepository.getUserProfile();
      final account = await _profileRepository.getAccountDetails();
      emit(ProfileLoaded(profile: profile, account: account));
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      UserProfile updatedProfile;

      switch (event.field) {
        case 'name':
          updatedProfile = UserProfile(
            name: event.value,
            email: currentState.profile.email,
            phone: currentState.profile.phone,
            pan: currentState.profile.pan,
            dob: currentState.profile.dob,
            profilePicUrl: currentState.profile.profilePicUrl,
          );
          break;
        case 'email':
          updatedProfile = UserProfile(
            name: currentState.profile.name,
            email: event.value,
            phone: currentState.profile.phone,
            pan: currentState.profile.pan,
            dob: currentState.profile.dob,
            profilePicUrl: currentState.profile.profilePicUrl,
          );
          break;
        case 'phone':
          updatedProfile = UserProfile(
            name: currentState.profile.name,
            email: currentState.profile.email,
            phone: event.value,
            pan: currentState.profile.pan,
            dob: currentState.profile.dob,
            profilePicUrl: currentState.profile.profilePicUrl,
          );
          break;
        default:
          return;
      }

      emit(
        ProfileLoaded(profile: updatedProfile, account: currentState.account),
      );
    }
  }

  Future<void> _onLogout(Logout event, Emitter<ProfileState> emit) async {
    try {
      await _profileRepository.logout();
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
