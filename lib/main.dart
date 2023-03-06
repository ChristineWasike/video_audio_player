import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_audio_player/video_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VideoPage(
          url:
              "https://d3iwe1dvhwwlbf.cloudfront.net/user2a4af8fbf5ab4b2eab54b91f789844ba/c32e5932-7a5b-4207-a417-be1f0094e9dd"),
    );
  }
}
