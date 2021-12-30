import 'dart:io';

import 'package:Youtube_flutter/models/channel_lnfo.dart';
import 'package:Youtube_flutter/models/search_video_lists.dart';
import 'package:Youtube_flutter/models/video_lists.dart';
import 'package:Youtube_flutter/utills/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';




class Services {
  static const DEFAULT_CHANNEL_ID = 'UC6lNIbU1SSA9YjveOx9a_oA';
  static const _baseUrl = 'www.googleapis.com';

  static Future<ChannelInfo> getChannelInfo(String channelId) async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': channelId,
      'key': Constants.API_KEY,
    };

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    Uri uri = Uri.https(
      _baseUrl,
      'youtube/v3/channels',
      parameters,
    );

    Response response = await http.get(uri, headers: headers);
    ChannelInfo channelInfo = channelInfoFromJson(response.body);
    return channelInfo;
  }


  static Future<VideosList> getVideosList(
      {String playListId, String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playListId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }

  static Future<SearchedVideoList> getSeachedVideosList(
      {String pageToken, String q}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'pageToken': pageToken,
      'q' : q,
      'regionCode': 'KR',
      'type': 'video',
      'maxResults': '8',
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/search',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    SearchedVideoList videosList = SearchedVideoListFromJson(response.body);
    return videosList;
  }


}
