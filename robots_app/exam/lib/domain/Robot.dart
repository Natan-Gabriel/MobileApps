


class Robot {
   int id;
   String name;
   String specs;
   int height;
   String type;
   int age;
   
  Robot(this.id, this.name,this.specs,this.height,this.type,this.age);

  // void setStudent(String s){
  //   student=s;
  // }

  // Map<String, dynamic> toLocalMap() {
  //   return {
  //     'title': title,
  //     'status': 'available',
  //     'student': student,
  //     'pages': pages,
  //     'usedCount': usedCount,
  //   };
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specs': specs,
      'height': height,
      'type': type,
      'age': age,
    };
  }

  Robot.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.specs = map['specs'];
    this.height = map['height'];
    this.type = map['type'];
    this.age = map['age'];
  }

@override
  bool operator ==(Object other) {
    Robot o=other;
    //if (this.tailNumber == o.tailNumber && this.aircraftType == o.aircraftType && this.airline == o.airline && this.flightCode == o.flightCode && this.terminal == o.terminal && this.gate == o.gate){
    if (this.id == o.id && this.name == o.name && this.specs == o.specs && this.height == o.height && this.type == o.type && this.age == o.age){
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
    return 'Entity{id: $id, name: $name, specs: $specs,height: $height, type: $type, age: $age}';
  }



}