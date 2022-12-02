class CommunityDTO {
  String id;
  String name;
  String? imageUrl;
  int usersCount;

  CommunityDTO({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.usersCount,
  });

  factory CommunityDTO.fromJson(Map<String, dynamic> json) {
    return CommunityDTO(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      usersCount: json['users_count'],
    );
  }
}
