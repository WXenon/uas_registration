import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Users {
  String username, admin;

  Users({this.username, this.admin});

  factory Users.fromJson(dynamic json){
    return Users(
        username : json['username'] as String,
        admin : json['admin'] as String
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

  factory Uas.fromJson(dynamic json){
    return Uas(
      username : json['username'] as String,
      uasname : json['uasname'] as String,
      baselinecheck : json['baselinecheck'] as String,
      physicalarea : json['physicalarea'] as String,
      uasdragcoef : json['uasdragcoef'] as String,
      maxthrust : json['maxthrust'] as String,
      propellerdiameter : json['propellerdiameter'] as String,
      propellerweight : json['propellerweight'] as String,
      noofbladepropeller: json['noofbladepropeller'] as String,
      propellerrpm : json['propellerrpm'] as String,
      propdragcoef : json['propdragcoef'] as String,
      maxgpsverterr : json['maxgpsverterr'] as String,
      maxgpshorerr : json['maxgpshorerr'] as String,
      battmodel : json['battmodel'] as String,
      batttype : json['batttype'] as String,
      battstandard : json['battstandard'] as String,
      battappoxmaxtime : json['battappoxmaxtime'] as String,
      battcap : json['battcap'] as String,
      battvolt : json['battvolt'] as String,
      battenergy : json['battenergy'] as String,
      oemoftethersystem : json['oemoftethersystem'] as String,
      materialoftether : json['materialoftether'] as String,
      strengthoftether : json['strengthoftether'] as String,
      anchortetheranchor : json['anchortetheranchor'] as String,
      jointtetheruas : json['jointtetheruas'] as String,
      strengthanchortetheranchor : json['strengthanchortetheranchor'] as String,
      strengthjointtetheruas : json['strengthjointtetheruas'] as String,
      method : json['method'] as String,
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

  factory Uasr.fromJson(dynamic json){
    return Uasr(
      uasname : json['uasname'] as String,
      baselinecheck : json['baselinecheck'] as String,
      physicalarea : json['physicalarea'] as String,
      uasdragcoef : json['uasdragcoef'] as String,
      maxthrust : json['maxthrust'] as String,
      propellerdiameter : json['propellerdiameter'] as String,
      propellerweight : json['propellerweight'] as String,
      noofbladepropeller: json['noofbladepropeller'] as String,
      propellerrpm : json['propellerrpm'] as String,
      propdragcoef : json['propdragcoef'] as String,
      maxgpsverterr : json['maxgpsverterr'] as String,
      maxgpshorerr : json['maxgpshorerr'] as String,
      battmodel : json['battmodel'] as String,
      batttype : json['batttype'] as String,
      battstandard : json['battstandard'] as String,
      battappoxmaxtime : json['battappoxmaxtime'] as String,
      battcap : json['battcap'] as String,
      battvolt : json['battvolt'] as String,
      battenergy : json['battenergy'] as String,
      oemoftethersystem : json['oemoftethersystem'] as String,
      materialoftether : json['materialoftether'] as String,
      strengthoftether : json['strengthoftether'] as String,
      anchortetheranchor : json['anchortetheranchor'] as String,
      jointtetheruas : json['jointtetheruas'] as String,
      strengthanchortetheranchor : json['strengthanchortetheranchor'] as String,
      strengthjointtetheruas : json['strengthjointtetheruas'] as String,
      method : json['method'] as String,
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