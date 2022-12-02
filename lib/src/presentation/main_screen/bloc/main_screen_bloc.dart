import 'package:chuck_norris/src/domain/repositories/community_repository.dart';
import 'package:chuck_norris/src/presentation/main_screen/states/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Cubit<MainScreenState> {
  final CommunityRepository _communityRepository;

  MainScreenBloc(this._communityRepository)
      : super(
          MainScreenState(
            communities: [],
          ),
        );

  void getData() {
    final communities = _communityRepository.getCommunities();

    emit(state.copyWith(loading: false, communities: communities));
  }
}
