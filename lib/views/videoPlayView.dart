// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayView extends ConsumerStatefulWidget {
  final String url;
  const VideoPlayView(this.url, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoPlayViewState();
}

class _VideoPlayViewState extends ConsumerState<VideoPlayView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _controller.pause();
                  },
                  child: const Icon(Icons.pause)),
              const SizedBox(
                width: 2,
              ),
              ElevatedButton(
                  onPressed: () {
                    _controller.play();
                  },
                  child: const Icon(Icons.play_arrow)),
              ElevatedButton(onPressed: () {}, child: const Icon(Icons.share))
            ],
          )
        ]));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
