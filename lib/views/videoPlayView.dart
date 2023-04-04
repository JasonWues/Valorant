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

class _VideoPlayViewState extends ConsumerState<VideoPlayView>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
      const SizedBox(
        height: 20,
      ),
      FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();

            if (animationController.isDismissed) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          });
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.pause_play,
          progress: animationController,
        ),
      )
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    animationController.dispose();
    super.dispose();
  }
}
