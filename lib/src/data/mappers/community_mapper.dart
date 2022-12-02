import 'package:chuck_norris/src/data/models/community_dto.dart';
import 'package:chuck_norris/src/domain/mappers/mapper.dart';
import 'package:chuck_norris/src/domain/models/community_item.dart';

class CommunityMapper extends Mapper<CommunityDTO, CommunityItem> {
  @override
  CommunityItem map(CommunityDTO input) {
    return CommunityItem(
      id: input.id,
      name: input.name,
      imageUrl: input.imageUrl,
      usersCount: input.usersCount,
    );
  }
}
