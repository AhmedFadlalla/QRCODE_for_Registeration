class UserModel{
  int? status;
  List<UserData>? data=[];
  UserModel({required this.status,required this.data});

   UserModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data =json['data'];
  }

   Map<String,dynamic> toJson(){
    final Map<String, dynamic> data =  Map<String, dynamic>();

    return {
      data['status']:status,
      data['data']:[
        {
          'data':data,
        }
      ]
    };
  }


}
class UserData{

  int? id,age,acadimic_year,payment_status,season;
  String? name,email,phone,city,university,college,attendee_code,question1,question2,question3,expects,comments,time;
  UserData({
    required this.id,
    required this.attendee_code,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.acadimic_year,
    required this.payment_status,
    required this.season,
    required this.university,
    required this.college,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.expects,
    required this.comments,
    required this.time,

  });

  UserData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    age=json['age'];
    city=json['city'];
    university=json['university'];
    college=json['college'];
    acadimic_year=json['acadimic_year'];
    question1=json['question1'];
    question2=json['question2'];
    question3=json['question3'];
    expects=json['expects'];
    comments=json['comments'];
    payment_status=json['payment_status'];
    season=json['season'];
    time=json['time'];
    attendee_code=json['attendee_code'];
  }

   Map<String,dynamic> toJson(){
    final Map<String, dynamic> data =  Map<String, dynamic>();

    return {
      data['id']:id,
      data['name']:name,
      data['email']:email,
      data['phone']:phone,
      data['age']:age,

    };
  }
}