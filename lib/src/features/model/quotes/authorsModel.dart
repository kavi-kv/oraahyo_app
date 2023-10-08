class AuthorsModel {
  String authorName;
  int count;

  AuthorsModel({ required this.authorName, required this.count });

  factory AuthorsModel.fromJson(Map<String,dynamic> json){
    return AuthorsModel(
    authorName: json['_id'],
    count: json['count']
    );

  }
}