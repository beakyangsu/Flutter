
import 'package:Youtube_flutter/models/channel_lnfo.dart';
import 'package:Youtube_flutter/models/search_video_lists.dart';
import 'package:Youtube_flutter/screens/channel_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class SearchedVideoPlayerScreen extends StatefulWidget {
  //
  SearchedVideoPlayerScreen({this.videoItem, this.channel});
  final VideoItem videoItem;
  final Item channel;


  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<SearchedVideoPlayerScreen> {
  //
  YoutubePlayerController _controller;
  bool _isPlayerReady;

  @override
  void initState() {
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoItem.id.videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      //
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
                _isPlayerReady = true;
              },
            ),
            _detailView(),
          ],
        ),
      ),
    );
  }

  _detailView() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(height: 30, width: 10),
            Container(
              child: Flexible(
                child: Text(
                  widget.videoItem.snippet.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(height: 3, color: Colors.grey.withOpacity(0.5)),
        SizedBox(height: 10),
        ExpansionTile(
          title: Text(
            widget.channel.snippet.description,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Divider(height: 3, color: Colors.grey.withOpacity(0.5)),
        SizedBox(height: 10),
        Row(
          children: [
            SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                widget.channel.snippet.thumbnails.thumbnailsDefault.url,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                widget.channel.snippet.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(height: 3, color: Colors.grey.withOpacity(0.5)),
        Container(),
      ],
    );
  }
}