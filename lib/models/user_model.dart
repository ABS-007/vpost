// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blackcoffer/models/video_model.dart';

class UserModel {
  final String? id;
  final String fullname;
  final String image;
  final String phoneno;
  final List<VideoModel> vidoes;

  UserModel(
    this.id,
    this.fullname,
    this.image,
    this.phoneno,
    this.vidoes,
  );
}
