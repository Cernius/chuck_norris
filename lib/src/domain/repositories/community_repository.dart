import 'package:chuck_norris/src/domain/models/community_item.dart';

abstract class CommunityRepository {
  List<CommunityItem> getCommunities();
}
