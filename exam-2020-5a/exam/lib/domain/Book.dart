


class Book {
   int id;
   String title;
   String status;
   String student;
   int pages;
   int usedCount;

  Book(this.id, this.title,this.status,this.student,this.pages,this.usedCount);

  void setStudent(String s){
    student=s;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'student': student,
      'pages': pages,
      'usedCount': usedCount,
    };
  }

  Book.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.status = map['status'];
    this.student = map['student'];
    this.pages = map['pages'];
    this.usedCount = map['usedCount'];
  }

@override
  bool operator ==(Object other) {
    Book o=other;
    //if (this.tailNumber == o.tailNumber && this.aircraftType == o.aircraftType && this.airline == o.airline && this.flightCode == o.flightCode && this.terminal == o.terminal && this.gate == o.gate){
    if (this.id == o.id && this.title == o.title && this.status == o.status && this.student == o.student && this.pages == o.pages && this.usedCount == o.usedCount){
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
    return 'Entity{id: $id, title: $title, status: $status,student: $student, pages: $pages, usedCount: $usedCount}';
  }



}