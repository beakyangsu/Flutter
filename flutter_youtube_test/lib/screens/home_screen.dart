

import 'package:Youtube_flutter/models/channel_lnfo.dart';
import 'package:Youtube_flutter/models/search_video_lists.dart';
import 'package:Youtube_flutter/screens/searchedvideo_player_sceen.dart';
import 'package:Youtube_flutter/screens/video_player_sceen.dart';
import 'package:Youtube_flutter/utills/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ChannelInfo _channelInfo;
  List<Item> _channels;
  SearchedVideoList _videosList;
  VideoItem _videoItem;
  bool _loading;
  String _nextPageToken;
  ScrollController _scrollController;
  SearchedVideoList tempVideosList;
  String _q;


  @override
  void initState() {
    super.initState();
    _loading = true;
    _q = '';
    _nextPageToken = '';
    _videosList = SearchedVideoList();
    _videosList.videos = [];
    _scrollController = ScrollController();
    _channels = [];
    _getSearechVideo();

  }

  _getSearechVideo() async {
    await _loadVideos();
    setState(() {
      _loading = false;
    });
  }


  _loadVideos() async {
    SearchedVideoList tempVideosList = (await Services.getSeachedVideosList(
      pageToken: _nextPageToken,
      q: _q,
    ));
    _nextPageToken = tempVideosList.nextPageToken;
    _videosList.videos.addAll(tempVideosList.videos);

    for (var i = 0; i< _videosList.videos.length; i++) {
      _channelInfo = await Services.getChannelInfo(_videosList.videos[i].snippet.channelId);
      _channels.add(_channelInfo.items[0]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube'),
        actions: [
          FloatingActionButton(
            child: Icon(Icons.search),
            onPressed: () {
              _searchView();
            }
          ),
        ],
      ),
      body: _loading
          ? CircularProgressIndicator()
          : Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (ScrollNotification notification) {
                  if (_videosList.videos.length >=
                      _videosList.pageInfo.totalResults) {
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
                    Item channel = _channels[index];
                    return InkWell(

                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return SearchedVideoPlayerScreen(
                                videoItem: videoItem,
                                 channel: channel,
                              );
                            }));
                      },
                      child: Container(
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: videoItem
                                  .snippet.thumbnails.high.url,
                            ),
                           SizedBox(height:5),
                            _VideoInfoView(channel, videoItem),
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

  _VideoInfoView(Item channel, VideoItem videoItem) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                channel.snippet.thumbnails.thumbnailsDefault.url,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoItem.snippet.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    channel.snippet.title,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _searchView(){
  }
}
