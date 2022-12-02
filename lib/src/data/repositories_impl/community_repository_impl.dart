import 'package:chuck_norris/src/data/mappers/community_mapper.dart';
import 'package:chuck_norris/src/data/server_api.dart';
import 'package:chuck_norris/src/domain/models/community_item.dart';
import 'package:chuck_norris/src/domain/repositories/community_repository.dart';

class CommunityRepositoryImpl extends CommunityRepository {
  final CommunityMapper _communityMapper;
  final ServerApi _serverApi;

  CommunityRepositoryImpl(this._communityMapper, this._serverApi);

  @override
  List<CommunityItem> getCommunities()  {
    final communitiesDTO = _serverApi.getCommunities();

    return communitiesDTO.map((e) => _communityMapper.map(e)).toList();
  }
}
