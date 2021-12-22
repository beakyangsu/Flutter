// To parse this JSON data, do
//
//     final videosListPoppular = videosListPoppularFromJson(jsonString);

import 'dart:convert';

VideosListPoppular videosListPoppularFromJson(String str) => VideosListPoppular.fromJson(json.decode(str));

String videosListPoppularToJson(VideosListPoppular data) => json.encode(data.toJson());

class VideosListPoppular {
    VideosListPoppular({
        this.kind,
        this.etag,
        this.items,
        this.nextPageToken,
        this.pageInfo,
    });

    String kind;
    String etag;
    List<Item> items;
    String nextPageToken;
    PageInfo pageInfo;

    factory VideosListPoppular.fromJson(Map<String, dynamic> json) => VideosListPoppular(
        kind: json["kind"],
        etag: json["etag"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        nextPageToken: json["nextPageToken"],
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "nextPageToken": nextPageToken,
        "pageInfo": pageInfo.toJson(),
    };
}

class Item {
    Item({
        this.kind,
        this.etag,
        this.id,
        this.snippet,
        this.contentDetails,
    });

    String kind;
    String etag;
    String id;
    Snippet snippet;
    ContentDetails contentDetails;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        snippet: Snippet.fromJson(json["snippet"]),
        contentDetails: ContentDetails.fromJson(json["contentDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "snippet": snippet.toJson(),
        "contentDetails": contentDetails.toJson(),
    };
}

class ContentDetails {
    ContentDetails({
        this.duration,
        this.dimension,
        this.definition,
        this.caption,
        this.licensedContent,
        this.contentRating,
        this.projection,
        this.regionRestriction,
    });

    String duration;
    String dimension;
    String definition;
    String caption;
    bool licensedContent;
    ContentRating contentRating;
    String projection;
    RegionRestriction regionRestriction;

    factory ContentDetails.fromJson(Map<String, dynamic> json) => ContentDetails(
        duration: json["duration"],
        dimension: json["dimension"],
        definition: json["definition"],
        caption: json["caption"],
        licensedContent: json["licensedContent"],
        contentRating: ContentRating.fromJson(json["contentRating"]),
        projection: json["projection"],
        regionRestriction: json["regionRestriction"] == null ? null : RegionRestriction.fromJson(json["regionRestriction"]),
    );

    Map<String, dynamic> toJson() => {
        "duration": duration,
        "dimension": dimension,
        "definition": definition,
        "caption": caption,
        "licensedContent": licensedContent,
        "contentRating": contentRating.toJson(),
        "projection": projection,
        "regionRestriction": regionRestriction == null ? null : regionRestriction.toJson(),
    };
}

class ContentRating {
    ContentRating();

    factory ContentRating.fromJson(Map<String, dynamic> json) => ContentRating(
    );

    Map<String, dynamic> toJson() => {
    };
}

class RegionRestriction {
    RegionRestriction({
        this.allowed,
    });

    List<String> allowed;

    factory RegionRestriction.fromJson(Map<String, dynamic> json) => RegionRestriction(
        allowed: List<String>.from(json["allowed"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "allowed": List<dynamic>.from(allowed.map((x) => x)),
    };
}

class Snippet {
    Snippet({
        this.publishedAt,
        this.channelId,
        this.title,
        this.description,
        this.thumbnails,
        this.channelTitle,
        this.categoryId,
        this.liveBroadcastContent,
        this.localized,
        this.defaultAudioLanguage,
        this.tags,
        this.defaultLanguage,
    });

    DateTime publishedAt;
    String channelId;
    String title;
    String description;
    Thumbnails thumbnails;
    String channelTitle;
    String categoryId;
    String liveBroadcastContent;
    Localized localized;
    String defaultAudioLanguage;
    List<String> tags;
    String defaultLanguage;

    factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        categoryId: json["categoryId"],
        liveBroadcastContent: json["liveBroadcastContent"],
        localized: Localized.fromJson(json["localized"]),
        defaultAudioLanguage: json["defaultAudioLanguage"],
        tags: json["tags"] == null ? null : List<String>.from(json["tags"].map((x) => x)),
        defaultLanguage: json["defaultLanguage"] == null ? null : json["defaultLanguage"],
    );

    Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails.toJson(),
        "channelTitle": channelTitle,
        "categoryId": categoryId,
        "liveBroadcastContent": liveBroadcastContent,
        "localized": localized.toJson(),
        "defaultAudioLanguage": defaultAudioLanguage,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "defaultLanguage": defaultLanguage == null ? null : defaultLanguage,
    };
}

class Localized {
    Localized({
        this.title,
        this.description,
    });

    String title;
    String description;

    factory Localized.fromJson(Map<String, dynamic> json) => Localized(
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
    };
}

class Thumbnails {
    Thumbnails({
        this.thumbnailsDefault,
        this.medium,
        this.high,
        this.standard,
        this.maxres,
    });

    Default thumbnailsDefault;
    Default medium;
    Default high;
    Default standard;
    Default maxres;

    factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault: Default.fromJson(json["default"]),
        medium: Default.fromJson(json["medium"]),
        high: Default.fromJson(json["high"]),
        standard: json["standard"] == null ? null : Default.fromJson(json["standard"]),
        maxres: json["maxres"] == null ? null : Default.fromJson(json["maxres"]),
    );

    Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault.toJson(),
        "medium": medium.toJson(),
        "high": high.toJson(),
        "standard": standard == null ? null : standard.toJson(),
        "maxres": maxres == null ? null : maxres.toJson(),
    };
}

class Default {
    Default({
        this.url,
        this.width,
        this.height,
    });

    String url;
    int width;
    int height;

    factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
    };
}

class PageInfo {
    PageInfo({
        this.totalResults,
        this.resultsPerPage,
    });

    int totalResults;
    int resultsPerPage;

    factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
    );

    Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
    };
}
