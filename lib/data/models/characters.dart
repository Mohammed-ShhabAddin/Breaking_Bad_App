class Character {
  late int charid;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statesIfDeadOrAlive;
  late List<dynamic> appearaenceOfseasons;
  late String actorName;
  late String categoryForTowSeries;
  late List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> json) {
    charid = json["char_id"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statesIfDeadOrAlive = json["status"];
    appearaenceOfseasons = json["appearance"];
    actorName = json["portrayed"];
    categoryForTowSeries = json["category"];
    betterCallSaulAppearance = json["better_call_saul_appearance"];
  }
}
