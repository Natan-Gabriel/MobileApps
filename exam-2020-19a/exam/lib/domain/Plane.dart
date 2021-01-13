import 'package:flutter/material.dart';

class Plane {
   int id;
   String name;
   String status;
   int size;
   String owner;
   String manufacturer;
   int capacity;

  Plane(this.id, this.name,this.status,this.size,this.owner,this.manufacturer,this.capacity);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'size': size,
      'owner': owner,
      'manufacturer': manufacturer,
      'capacity': capacity,
    };
  }

  Plane.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.status = map['status'];
    this.size = int.parse(map['size']);
    this.owner = map['owner'];
    this.manufacturer = map['manufacturer'];
    this.capacity = int.parse(map['capacity']);
  }

@override
  bool operator ==(Object other) {
    Plane o=other;
    //if (this.tailNumber == o.tailNumber && this.aircraftType == o.aircraftType && this.airline == o.airline && this.flightCode == o.flightCode && this.terminal == o.terminal && this.gate == o.gate){
    if (this.id == o.id){
      return true;
    }
    else{
      return false;
    }
  }

  // static Aircraft fromMap(Map<String, dynamic> map) {
  //   return Aircraft(map[tailNumber],map[aircraftType],map[airline],map[flightCode],map[terminal],map[gate]);
  // }

  @override
  String toString() {
    return 'Plane{id: $id, name: $name, status: $status,size: $size, owner: $owner, manufacturer: $manufacturer, capacity: $capacity}';
  }



}