import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends ConsumerStatefulWidget {
  final String url;
  const VideoPage({Key? key, required this.url}) : super(key: key);

  @override
  ConsumerState<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () => init());
  }

  init() async {
    await ref.read(videoPlayerControllerProvider.notifier).init(
        "https://d3iwe1dvhwwlbf.cloudfront.net/user2a4af8fbf5ab4b2eab54b91f789844ba/c32e5932-7a5b-4207-a417-be1f0094e9dd");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              ref.read(videoPlayerControllerProvider.notifier).pause();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const VideoPage(
                      url:
                          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
                ),
              );
            },
            child: const Text('Video Page')),
        actions: const [
          VolumeOnOffButton(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(ref.watch(videoPlayerControllerProvider)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

final videoPlayerControllerProvider =
    StateNotifierProvider<VideoPlayerControllerProvider, VideoPlayerController>(
        (ref) => VideoPlayerControllerProvider());

class VideoPlayerControllerProvider
    extends StateNotifier<VideoPlayerController> {
  VideoPlayerControllerProvider() : super(VideoPlayerController.network(''));

  toggleVolume() {
    state.setVolume(state.value.volume == 0 ? 1 : 0);
  }

  init(String url) async {
    state = VideoPlayerController.network(url);
    await state.initialize();
    state.play();
  }

  void pause() async {
    await state.pause();
  }
}

// A BUTTON THAT TOGGLES THE VOLUME OF THE VIDEO PLAYER CONTROLLER

class VolumeOnOffButton extends ConsumerStatefulWidget {
  const VolumeOnOffButton({super.key});

  @override
  ConsumerState<VolumeOnOffButton> createState() => _VolumeOnOffButtonState();
}

class _VolumeOnOffButtonState extends ConsumerState<VolumeOnOffButton> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return IconButton(
      icon: ref.watch(videoPlayerControllerProvider).value.volume == 0
          ? const Icon(Icons.volume_off)
          : const Icon(Icons.volume_up),
      onPressed: () {
        ref.read(videoPlayerControllerProvider.notifier).toggleVolume();
        setState(() {});
      },
    );
  }
}
