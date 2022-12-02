import 'dart:convert';
import 'package:chuck_norris/src/data/models/community_dto.dart';
import 'package:chuck_norris/src/domain/repositories/preference_repository.dart';
import 'package:http/http.dart' as http;

class ServerApi {
  final PreferenceRepository _preferenceRepository;

  ServerApi(this._preferenceRepository);

  Future<http.Response> getData(
    String endpoint, {
    Map<String, String>? query,
  }) async {
    Uri url = Uri.https(_preferenceRepository.getServerUrl(), endpoint, query);

    dynamic response;
    response = await http.get(url);

    return response;
  }

  List<CommunityDTO> getCommunities() {
    final body = json.decode(demoJson);

    return body
        .map<CommunityDTO>((model) => CommunityDTO.fromJson(model))
        .toList();
  }
}

String demoJson = '''
[
        {
            "id": "4de3f516-dbbc-4214-8969-15c60f8c7471",
            "name": "announcements UI",
            "image_url": null,
            "users_count": 14
        },
        {
            "id": "dc8b39d3-509f-4ce6-b093-c3b394b56856",
            "name": "All About Crypto ⚡️",
            "image_url": "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
            "users_count": 9
        },
        {
            "id": "9229ed6e-e936-4559-a4ef-cba9f5624877",
            "name": "auri5mac com",
            "image_url": "https://storage.googleapis.com/dev-public-storage-bucket-outgrid/communities%2F9229ed6e-e936-4559-a4ef-cba9f5624877%2F1666684289004.jpg",
            "users_count": 8
        },
        {
            "id": "5be00c45-c187-4f9a-9c3f-f8f06c42d757",
            "name": "Dainius comm",
            "image_url": "https://storage.googleapis.com/dev-public-storage-bucket-outgrid/communities/5be00c45-c187-4f9a-9c3f-f8f06c42d757/1649104645079.jpg",
            "users_count": 6
        },
        {
            "id": "0118c489-9551-4956-a864-ceb1feaf5e3b",
            "name": "Lalalaat",
            "image_url": "https://storage.googleapis.com/dev-public-storage-bucket-outgrid/communities%2F0118c489-9551-4956-a864-ceb1feaf5e3b%2F1658404504854.jpg",
            "users_count": 3
        },
        {
            "id": "2d3c363e-6e53-4b5d-aaf8-8f42cec1fda8",
            "name": "ewqqe",
            "image_url": null,
            "users_count": 3
        },
        {
            "id": "c41d7983-cb52-48c7-8358-d26b6d2ef820",
            "name": "ewqqwe",
            "image_url": null,
            "users_count": 3
        },
        {
            "id": "74a9b786-d6d7-4fb9-8b84-67aebca3f4c2",
            "name": "New",
            "image_url": null,
            "users_count": 2
        },
        {
            "id": "e364c293-c3a7-4ec8-bd84-0cace59bc027",
            "name": "Androids 2 ",
            "image_url": "https://storage.googleapis.com/dev-public-storage-bucket-outgrid/communities%2Fe364c293-c3a7-4ec8-bd84-0cace59bc027%2F1662985120499.jpg",
            "users_count": 2
        },
        {
            "id": "8e78f0d9-1d68-4649-9c36-55b329bdeb03",
            "name": "wqqweqdsaaseweqsdaasd",
            "image_url": null,
            "users_count": 2
        },
        {
            "id": "d5e9fb53-0b84-42a0-af6f-2d6078b3081a",
            "name": "qweqweewq",
            "image_url": null,
            "users_count": 2
        },
        {
            "id": "22eaa6cf-8c45-43f2-819f-0528f2f962d9",
            "name": "Vvv",
            "image_url": null,
            "users_count": 2
        },
        {
            "id": "2e0013bc-bf29-4bdd-9663-8c79b480a934",
            "name": "Ne ",
            "image_url": "https://storage.googleapis.com/dev-public-storage-bucket-outgrid/communities%2F2e0013bc-bf29-4bdd-9663-8c79b480a934%2F1663171938856.jpg",
            "users_count": 2
        },
        {
            "id": "5a1fc2d9-ae24-4f4b-af20-fddacf00d5df",
            "name": "dsasaddsdas",
            "image_url": null,
            "users_count": 2
        },
        {
            "id": "ddcba8f1-f6b3-4e5a-9da7-5e939ad29c95",
            "name": "macprivate",
            "image_url": null,
            "users_count": 2
        }
    ]
''';
