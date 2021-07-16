import 'dart:convert';

DataValidateAccount dataValidateAccountFromJson(String str) => DataValidateAccount.fromJson(json.decode(str));

String dataValidateAccountToJson(DataValidateAccount data) => json.encode(data.toJson());

class DataValidateAccount {
  DataValidateAccount({
    this.errorType,
    this.errorMessage,
    this.userData,
    this.faceData,
  });

  int errorType;
  String errorMessage;
  UserData userData;
  FaceData faceData;

  factory DataValidateAccount.fromJson(Map<String, dynamic> json) => DataValidateAccount(
    errorType: json["error_type"],
    errorMessage: json["error_message"],
    userData: UserData.fromJson(json["userData"]),
    faceData: FaceData.fromJson(json["faceData"]),
  );

  Map<String, dynamic> toJson() => {
    "error_type": errorType,
    "error_message": errorMessage,
    "userData": userData.toJson(),
    "faceData": faceData.toJson(),
  };
}

class FaceData {
  FaceData({
    this.similarity,
    this.match,
    this.bothImgIdCard,
  });

  double similarity;
  bool match;
  bool bothImgIdCard;

  factory FaceData.fromJson(Map<String, dynamic> json) => FaceData(
    similarity: json["similarity"],
    match: json["match"],
    bothImgIdCard: json["bothImgIDCard"],
  );

  Map<String, dynamic> toJson() => {
    "similarity": similarity,
    "match": match,
    "bothImgIDCard": bothImgIdCard,
  };
}

class UserData {
  UserData({
    this.id,
    this.idProb,
    this.name,
    this.nameProb,
    this.dob,
    this.dobProb,
    this.sex,
    this.sexProb,
    this.nationality,
    this.nationalityProb,
    this.typeNew,
    this.doe,
    this.doeProb,
    this.home,
    this.homeProb,
    this.address,
    this.addressProb,
    this.addressEntities,
    this.overallScore,
    this.type,
  });

  String id;
  String idProb;
  String name;
  String nameProb;
  String dob;
  String dobProb;
  String sex;
  String sexProb;
  String nationality;
  String nationalityProb;
  String typeNew;
  String doe;
  String doeProb;
  String home;
  String homeProb;
  String address;
  String addressProb;
  AddressEntities addressEntities;
  String overallScore;
  String type;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    idProb: json["id_prob"],
    name: json["name"],
    nameProb: json["name_prob"],
    dob: json["dob"],
    dobProb: json["dob_prob"],
    sex: json["sex"],
    sexProb: json["sex_prob"],
    nationality: json["nationality"],
    nationalityProb: json["nationality_prob"],
    typeNew: json["type_new"],
    doe: json["doe"],
    doeProb: json["doe_prob"],
    home: json["home"],
    homeProb: json["home_prob"],
    address: json["address"],
    addressProb: json["address_prob"],
    addressEntities: AddressEntities.fromJson(json["address_entities"]),
    overallScore: json["overall_score"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_prob": idProb,
    "name": name,
    "name_prob": nameProb,
    "dob": dob,
    "dob_prob": dobProb,
    "sex": sex,
    "sex_prob": sexProb,
    "nationality": nationality,
    "nationality_prob": nationalityProb,
    "type_new": typeNew,
    "doe": doe,
    "doe_prob": doeProb,
    "home": home,
    "home_prob": homeProb,
    "address": address,
    "address_prob": addressProb,
    "address_entities": addressEntities.toJson(),
    "overall_score": overallScore,
    "type": type,
  };
}

class AddressEntities {
  AddressEntities({
    this.additionalProp1,
    this.additionalProp2,
    this.additionalProp3,
  });

  String additionalProp1;
  String additionalProp2;
  String additionalProp3;

  factory AddressEntities.fromJson(Map<String, dynamic> json) => AddressEntities(
    additionalProp1: json["additionalProp1"],
    additionalProp2: json["additionalProp2"],
    additionalProp3: json["additionalProp3"],
  );

  Map<String, dynamic> toJson() => {
    "additionalProp1": additionalProp1,
    "additionalProp2": additionalProp2,
    "additionalProp3": additionalProp3,
  };
}
