import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo(this.videopath, {super.key});
  final File videopath;

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.videopath)
      ..initialize().then((_) {
        setState(() {});
      });
    controller.setLooping(true);
    controller.setVolume(1.0);
  }

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _location = TextEditingController();

  //adding video to firebase

  Future<void> addvideo(String title, String description, String category,
      String location, File video) async {
    CollectionReference videos =
        FirebaseFirestore.instance.collection('videos');
    return videos
        .add({
          'title': title,
          'description': description,
          'category': category,
          'location': location,
        })
        .then((value) => debugPrint("Video Added"))
        .catchError((error) => debugPrint("Failed to add Video: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
              ),
              onPressed: () {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
                setState(() {});
              },
              child: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            _TextField(controller: _title, name: "Title"),
            _TextField(controller: _description, name: "Description"),
            _TextField(controller: _category, name: "Category"),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Location cannot be Empty";
                    }
                  }
                  return "";
                },
                onChanged: (value) {
                  _location.text = value;
                },
                decoration: InputDecoration(
                  labelText: "Location",
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addvideo(_title.text, _description.text, _category.text,
                      _location.text, widget.videopath);
                  Navigator.pushNamed(context, "home");
                },
                child: Text("Post"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
    required TextEditingController controller,
    required this.name,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        validator: (value) {
          if (value != null) {
            if (value.isEmpty) {
              return "$name cannot be Empty";
            }
          }
          return "";
        },
        onChanged: (value) {
          _controller.text = value;
        },
        decoration: InputDecoration(
          labelText: name,
        ),
      ),
    );
  }
}
