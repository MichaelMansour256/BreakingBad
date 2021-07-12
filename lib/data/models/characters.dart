class Character {
  int charId;
  String name;
  String nickName;
  String image;
  List<dynamic> jobs;
  String statusIfDeadOrAlive;
  List<dynamic> apperanceOfSeasons;
  String actorName;
  String categoryForBBAndBCS;
  List<dynamic> apperanceOfSeasonsBCS;
  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    nickName = json['nickname'];
    image = json['img'];
    jobs = json['occupation'];
    statusIfDeadOrAlive = json['status'];
    apperanceOfSeasons = json['appearance'];
    actorName = json['portrayed'];
    categoryForBBAndBCS = json['category'];
    apperanceOfSeasonsBCS = json['better_call_saul_appearance'];
  }
}
