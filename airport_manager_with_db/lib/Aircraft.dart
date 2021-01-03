import 'package:flutter/material.dart';

class Aircraft {
  final String tailNumber;
  final String aircraftType;
  final String airline;
  final String flightCode;
  final String terminal;
  final String gate;

  Aircraft(this.tailNumber, this.aircraftType,this.airline,this.flightCode,this.terminal,this.gate);

  Map<String, dynamic> toMap() {
    return {
      'tailNumber': tailNumber,
      'aircraftType': aircraftType,
      'airline': airline,
      'flightCode': flightCode,
      'terminal': terminal,
      'gate': gate,
    };
  }

  // static Aircraft fromMap(Map<String, dynamic> map) {
  //   return Aircraft(map[tailNumber],map[aircraftType],map[airline],map[flightCode],map[terminal],map[gate]);
  // }

  @override
  String toString() {
    return 'Aircraft{tailNumber: $tailNumber, aircraftType: $aircraftType, airline: $airline,flightCode: $flightCode, terminal: $terminal, gate: $gate}';
  }



}