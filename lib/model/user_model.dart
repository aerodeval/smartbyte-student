class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? course;
  String? password;
  String? role;
  String? pno;
  String? branch;
  String? rno;
  UserModel({this.uid, this.email, this.firstName,  this.course,this.password,this.role,this.pno,this.branch,this.rno});


  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      course: map['courseName'],
      password:map['passwordLogin']
      ,
      role:map['role'],
      pno: map['phone'],
      branch:map['branch'],
      rno: map['rno']
      
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'courseName':course,
      'passwordLogin':password,
      'role':role,
      'phone':pno,
      'branch':branch
      ,'rno':rno
    };
  }
}