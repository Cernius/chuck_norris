class JokeDTO {
  String value;
  String iconUrl;
  String id;

  JokeDTO({required this.iconUrl, required this.id, required this.value});

  ///I didn't use json serializable cause there is only 1 object in this api
  factory JokeDTO.fromJson(Map<String, dynamic> json) {
    return JokeDTO(
      iconUrl: json['icon_url'],
      id: json['id'],
      value: json['value'],
    );
  }
}
