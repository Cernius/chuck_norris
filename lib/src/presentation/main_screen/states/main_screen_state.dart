import 'package:chuck_norris/src/domain/models/community_item.dart';

class MainScreenState {
  final List<CommunityItem> communities;
  final bool loading;

  MainScreenState({required this.communities, this.loading = true});

  MainScreenState copyWith({
    List<CommunityItem>? communities,
    bool? loading,
  }) {
    return MainScreenState(
      communities: communities ?? this.communities,
      loading: loading ?? this.loading,
    );
  }
}
