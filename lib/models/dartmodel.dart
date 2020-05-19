import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Users {
  String username, admin;

  Users(this.username, this.admin);

  factory Users.fromJson(dynamic json){
    return Users(json['username'] as String, json['admin'] as String);
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

  Uas(this.username, this.uasname, this.baselinecheck, this.physicalarea, this.uasdragcoef, this.maxthrust, this.propellerdiameter, this.propellerweight,
    this.noofbladepropeller, this.propellerrpm, this.propdragcoef, this.maxgpsverterr, this.maxgpshorerr, this.battmodel, this.batttype, this.battstandard,
    this.battappoxmaxtime, this.battcap, this.battvolt, this.battenergy, this.oemoftethersystem, this.materialoftether, this.strengthoftether, this.anchortetheranchor,
    this.jointtetheruas, this.strengthanchortetheranchor, this.strengthjointtetheruas, this.method);

  factory Uas.fromJson(dynamic json){
    return Uas(
      json['username'] as String,
      json['uasname'] as String,
      json['baselinecheck'] as String,
      json['physicalarea'] as String,
      json['uasdragcoef'] as String,
      json['maxthrust'] as String,
      json['propellerdiameter'] as String,
      json['propellerweight'] as String,
      json['noofbladepropeller'] as String,
      json['propellerrpm'] as String,
      json['propdragcoef'] as String,
      json['maxgpsverterr'] as String,
      json['maxgpshorerr'] as String,
      json['battmodel'] as String,
      json['batttype'] as String,
      json['battstandard'] as String,
      json['battappoxmaxtime'] as String,
      json['battcap'] as String,
      json['battvolt'] as String,
      json['battenergy'] as String,
      json['oemoftethersystem'] as String,
      json['materialoftether'] as String,
      json['strengthoftether'] as String,
      json['anchortetheranchor'] as String,
      json['jointtetheruas'] as String,
      json['strengthanchortetheranchor'] as String,
      json['strengthjointtetheruas'] as String,
      json['method'] as String,
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

  Uasr(this.uasname, this.baselinecheck, this.physicalarea, this.uasdragcoef, this.maxthrust, this.propellerdiameter, this.propellerweight,
    this.noofbladepropeller, this.propellerrpm, this.propdragcoef, this.maxgpsverterr, this.maxgpshorerr, this.battmodel, this.batttype, this.battstandard,
    this.battappoxmaxtime, this.battcap, this.battvolt, this.battenergy, this.oemoftethersystem, this.materialoftether, this.strengthoftether, this.anchortetheranchor,
    this.jointtetheruas, this.strengthanchortetheranchor, this.strengthjointtetheruas, this.method);

  factory Uasr.fromJson(dynamic json){
    return Uasr(
      json['uasname'] as String,
      json['baselinecheck'] as String,
      json['physicalarea'] as String,
      json['uasdragcoef'] as String,
      json['maxthrust'] as String,
      json['propellerdiameter'] as String,
      json['propellerweight'] as String,
      json['noofbladepropeller'] as String,
      json['propellerrpm'] as String,
      json['propdragcoef'] as String,
      json['maxgpsverterr'] as String,
      json['maxgpshorerr'] as String,
      json['battmodel'] as String,
      json['batttype'] as String,
      json['battstandard'] as String,
      json['battappoxmaxtime'] as String,
      json['battcap'] as String,
      json['battvolt'] as String,
      json['battenergy'] as String,
      json['oemoftethersystem'] as String,
      json['materialoftether'] as String,
      json['strengthoftether'] as String,
      json['anchortetheranchor'] as String,
      json['jointtetheruas'] as String,
      json['strengthanchortetheranchor'] as String,
      json['strengthjointtetheruas'] as String,
      json['method'] as String,
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