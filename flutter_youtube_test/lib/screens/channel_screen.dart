import 'package:Youtube_flutter/models/channel_lnfo.dart';
import 'package:Youtube_flutter/models/video_lists.dart';
import 'package:Youtube_flutter/screens/video_player_sceen.dart';
import 'package:Youtube_flutter/utills/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ChannelScreen extends StatefulWidget {
  @override
  ChannelScreen({this.channelId});
  String channelId;

  _ChannelScreenState createState() => _ChannelScreenState();

}

class _ChannelScreenState extends State<ChannelScreen> {
  //
  ChannelInfo _channelInfo;
  VideosList _videosList;
  Item _item;
  bool _loading;
  String _playListId;
  String _nextPageToken;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList.videos = [];
    _getChannelInfo();
  }

  _getChannelInfo() async {
    // _channelInfo = await Services.getChannelInfo(Services.DEFAULT_CHANNEL_ID);
    // _item = _channelInfo.items[0];
    // _playListId = _item.contentDetails.relatedPlaylists.uploads;
    await _loadVideos();
    setState(() {
      _loading = false;
    });
  }

  _loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList(
      playListId: _playListId,
      pageToken: _nextPageToken,
    );
    _nextPageToken = tempVideosList.nextPageToken;
    _videosList.videos.addAll(tempVideosList.videos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'YouTube'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildInfoView(),
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (ScrollNotification notification) {
                  if (_videosList.videos.length >=
                      int.parse(_item.statistics.videoCount)) {
                    return true;
                  }
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                      _loadVideos();
                  }
                  return true;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _videosList.videos.length,
                  itemBuilder: (context, index) {
                    VideoItem videoItem = _videosList.videos[index];
                    return InkWell(
                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return VideoPlayerScreen(
                                videoItem: videoItem,
                              );
                            }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: videoItem
                                  .video.thumbnails.thumbnailsDefault.url,
                            ),
                           SizedBox(width:20),
                           Flexible(child: Text(videoItem.video.title)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildInfoView() {
    return _loading
        ? CircularProgressIndicator()
        : Container(
      padding: EdgeInsets.all(20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  _item.snippet.thumbnails.medium.url,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  _item.snippet.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(_item.statistics.videoCount),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
