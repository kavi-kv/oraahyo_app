// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavoriteModel {
  final String id;
  final String quoteId;
  final String quoteTxt;
  final String imgUrl;
  final String author;
  
  FavoriteModel({
    required this.id,
    required this.quoteId,
    required this.quoteTxt,
    required this.imgUrl,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'quoteTxt': quoteTxt,
      'imgUrl': imgUrl,
      'author': author,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as String,
      quoteId: map['quoteId'] as String,
      quoteTxt: map['quoteTxt'] as String,
      imgUrl: map['imgUrl'] as String,
      author: map['author'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quoteTxt': quoteTxt,
      'imgUrl': imgUrl,
      'author': author,
    };
  }

  @override
  String toString() {
    return 'FavoriteModel{id: $id, quoteTxt: $quoteTxt, imgUrl: $imgUrl, author: $author}';
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['_id'] as String? ?? '',
      quoteId: json['quoteId'],
      quoteTxt: json['quoteTxt'] as String? ?? '',
      imgUrl: json['imgUrl'] as String? ?? '',
      author: json['author'] as String? ?? '',
    );
  }
}
