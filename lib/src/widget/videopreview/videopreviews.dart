import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final File videoFile;

  VideoPreviewScreen({required this.videoFile});

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
late  final VideoPlayerController _controller ;
@override
void initState() {
  super.initState();
  _controller = VideoPlayerController.file(widget.videoFile);

  _controller.addListener(() {
    setState(() {});
  });
  _controller.setLooping(true);
  _controller.initialize().then((_) => setState(() {}));
  _controller.pause();
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}



  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Container(
          width: 250,
            height: 100,
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : const CircularProgressIndicator(),
          ),

       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text(formatDuration(_controller.value.duration), style: const TextStyle(color: Colors.white),),
           FloatingActionButton(
             mini: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
      ),
         ],
       ),
   ] );
  }
String formatDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

}
