import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Users {
  String username, admin;

  Users({this.username, this.admin});

  factory Users.fromJson(Map<String, dynamic> json){
    return Users(
        username : json['username'],
        admin : json['admin']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'admin': admin,
      };

//  print('Howdy, ${user.name}!');
//  print('We sent the verification link to ${user.email}.');
}

@JsonSerializable(nullable: true)
class Uas {
  String username, uasname, baselinecheck, physicalarea, uasdragcoef, maxthrust, propellerdiameter, propellerweight,
  noofbladepropeller, propellerrpm, propdragcoef, maxgpsverterr, maxgpshorerr, battmodel, batttype, battstandard,
  battappoxmaxtime, battcap, battvolt, battenergy, oemoftethersystem, materialoftether, strengthoftether, anchortetheranchor,
  jointtetheruas, strengthanchortetheranchor, strengthjointtetheruas, method;

  Uas({this.username, this.uasname, this.baselinecheck, this.physicalarea, this.uasdragcoef, this.maxthrust, this.propellerdiameter, this.propellerweight,
    this.noofbladepropeller, this.propellerrpm, this.propdragcoef, this.maxgpsverterr, this.maxgpshorerr, this.battmodel, this.batttype, this.battstandard,
    this.battappoxmaxtime, this.battcap, this.battvolt, this.battenergy, this.oemoftethersystem, this.materialoftether, this.strengthoftether, this.anchortetheranchor,
    this.jointtetheruas, this.strengthanchortetheranchor, this.strengthjointtetheruas, this.method});

  factory Uas.fromJson(Map<String, dynamic> json){
    return Uas(
      username : json['username'],
      uasname : json['uasname'],
      baselinecheck : json['baselinecheck'],
      physicalarea : json['physicalarea'],
      uasdragcoef : json['uasdragcoef'],
      maxthrust : json['maxthrust'],
      propellerdiameter : json['propellerdiameter'],
      propellerweight : json['propellerweight'],
      noofbladepropeller: json['noofbladepropeller'],
      propellerrpm : json['propellerrpm'],
      propdragcoef : json['propdragcoef'],
      maxgpsverterr : json['maxgpsverterr'],
      maxgpshorerr : json['maxgpshorerr'],
      battmodel : json['battmodel'],
      batttype : json['batttype'],
      battstandard : json['battstandard'],
      battappoxmaxtime : json['battappoxmaxtime'],
      battcap : json['battcap'],
      battvolt : json['battvolt'],
      battenergy : json['battenergy'],
      oemoftethersystem : json['oemoftethersystem'],
      materialoftether : json['materialoftether'],
      strengthoftether : json['strengthoftether'],
      anchortetheranchor : json['anchortetheranchor'],
      jointtetheruas : json['jointtetheruas'],
      strengthanchortetheranchor : json['strengthanchortetheranchor'],
      strengthjointtetheruas : json['strengthjointtetheruas'],
      method : json['method'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'uasname' : uasname,
        'baselinecheck' : baselinecheck,
        'physicalarea' : physicalarea,
        'uasdragcoef' : uasdragcoef,
        'maxthrust' : maxthrust,
        'propellerdiameter' : propellerdiameter,
        'propellerweight' : propellerweight,
        'noofbladepropeller': noofbladepropeller,
        'propellerrpm' : propellerrpm,
        'propdragcoef' : propdragcoef,
        'maxgpsverterr' : maxgpsverterr,
        'maxgpshorerr' : maxgpshorerr,
        'battmodel' : battmodel,
        'batttype' : batttype,
        'battstandard' : battstandard,
        'battappoxmaxtime' : battappoxmaxtime,
        'battcap' : battcap,
        'battvolt' : battvolt,
        'battenergy' : battenergy,
        'oemoftethersystem' : oemoftethersystem,
        'materialoftether' : materialoftether,
        'strengthoftether' : strengthoftether,
        'anchortetheranchor' : anchortetheranchor,
        'jointtetheruas' : jointtetheruas,
        'strengthanchortetheranchor' : strengthanchortetheranchor,
        'strengthjointtetheruas' : strengthjointtetheruas,
        'method' : method,
      };
}

@JsonSerializable(nullable: true)
class Uasr {
  String uasname, baselinecheck, physicalarea, uasdragcoef, maxthrust, propellerdiameter, propellerweight,
      noofbladepropeller, propellerrpm, propdragcoef, maxgpsverterr, maxgpshorerr, battmodel, batttype, battstandard,
      battappoxmaxtime, battcap, battvolt, battenergy, oemoftethersystem, materialoftether, strengthoftether, anchortetheranchor,
      jointtetheruas, strengthanchortetheranchor, strengthjointtetheruas, method;

  Uasr({this.uasname, this.baselinecheck, this.physicalarea, this.uasdragcoef, this.maxthrust, this.propellerdiameter, this.propellerweight,
    this.noofbladepropeller, this.propellerrpm, this.propdragcoef, this.maxgpsverterr, this.maxgpshorerr, this.battmodel, this.batttype, this.battstandard,
    this.battappoxmaxtime, this.battcap, this.battvolt, this.battenergy, this.oemoftethersystem, this.materialoftether, this.strengthoftether, this.anchortetheranchor,
    this.jointtetheruas, this.strengthanchortetheranchor, this.strengthjointtetheruas, this.method});

  factory Uasr.fromJson(Map<String, dynamic> json){
    return Uasr(
      uasname : json['uasname'],
      baselinecheck : json['baselinecheck'],
      physicalarea : json['physicalarea'],
      uasdragcoef : json['uasdragcoef'],
      maxthrust : json['maxthrust'],
      propellerdiameter : json['propellerdiameter'],
      propellerweight : json['propellerweight'],
      noofbladepropeller: json['noofbladepropeller'],
      propellerrpm : json['propellerrpm'],
      propdragcoef : json['propdragcoef'],
      maxgpsverterr : json['maxgpsverterr'],
      maxgpshorerr : json['maxgpshorerr'],
      battmodel : json['battmodel'],
      batttype : json['batttype'],
      battstandard : json['battstandard'],
      battappoxmaxtime : json['battappoxmaxtime'],
      battcap : json['battcap'],
      battvolt : json['battvolt'],
      battenergy : json['battenergy'],
      oemoftethersystem : json['oemoftethersystem'],
      materialoftether : json['materialoftether'],
      strengthoftether : json['strengthoftether'],
      anchortetheranchor : json['anchortetheranchor'],
      jointtetheruas : json['jointtetheruas'],
      strengthanchortetheranchor : json['strengthanchortetheranchor'],
      strengthjointtetheruas : json['strengthjointtetheruas'],
      method : json['method'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'uasname' : uasname,
        'baselinecheck' : baselinecheck,
        'physicalarea' : physicalarea,
        'uasdragcoef' : uasdragcoef,
        'maxthrust' : maxthrust,
        'propellerdiameter' : propellerdiameter,
        'propellerweight' : propellerweight,
        'noofbladepropeller': noofbladepropeller,
        'propellerrpm' : propellerrpm,
        'propdragcoef' : propdragcoef,
        'maxgpsverterr' : maxgpsverterr,
        'maxgpshorerr' : maxgpshorerr,
        'battmodel' : battmodel,
        'batttype' : batttype,
        'battstandard' : battstandard,
        'battappoxmaxtime' : battappoxmaxtime,
        'battcap' : battcap,
        'battvolt' : battvolt,
        'battenergy' : battenergy,
        'oemoftethersystem' : oemoftethersystem,
        'materialoftether' : materialoftether,
        'strengthoftether' : strengthoftether,
        'anchortetheranchor' : anchortetheranchor,
        'jointtetheruas' : jointtetheruas,
        'strengthanchortetheranchor' : strengthanchortetheranchor,
        'strengthjointtetheruas' : strengthjointtetheruas,
        'method' : method,
      };
}