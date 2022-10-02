import 'package:emekteb/core/base/models/base_model.dart';

class ChatMessageFromController extends BaseModel<ChatMessageFromController> {
  List<ChatMessageFromContent>? content;
  Pageable? pageable;
  bool? last;
  num? totalElements;
  num? totalPages;
  num? size;
  Sort? sort;
  bool? first;
  num? numberOfElements;
  num? number;
  bool? empty;

  ChatMessageFromController({
    this.content,
    this.pageable,
    this.last,
    this.totalElements,
    this.totalPages,
    this.size,
    this.sort,
    this.first,
    this.numberOfElements,
    this.number,
    this.empty,
  });

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    data['last'] = last;
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
    data['size'] = size;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['first'] = first;
    data['numberOfElements'] = numberOfElements;
    data['number'] = number;
    data['empty'] = empty;
    return data;
  }

  @override
  ChatMessageFromController fromJson(Map<String, dynamic> json) {
    return ChatMessageFromController(
      content: json["content"] != null
          ? List<ChatMessageFromContent>.from(
              json["content"].map((x) => ChatMessageFromContent.fromJson(x)),
            )
          : null,
      pageable:
          json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null,
      last: json['last'],
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      size: json['size'],
      sort: json['sort'] != null ? Sort.fromJson(json['sort']) : null,
      first: json['first'],
      numberOfElements: json['numberOfElements'],
      number: json['number'],
      empty: json['empty'],
    );
  }
}

class ChatMessageFromContent {
  String? id;
  String? message;
  UserFrom? userFrom;
  UserFrom? userTo;
  String? dateTime;
  bool? owner;
  bool? NEW;

  ChatMessageFromContent(
      {this.id,
      this.message,
      this.userFrom,
      this.userTo,
      this.dateTime,
      this.owner,
      this.NEW});

  ChatMessageFromContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    userFrom =
        json['userFrom'] != null ? UserFrom.fromJson(json['userFrom']) : null;
    userTo = json['userTo'] != null ? UserFrom.fromJson(json['userTo']) : null;
    dateTime = json['dateTime'];
    owner = json['owner'];
    NEW = json['new'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    if (userFrom != null) {
      data['userFrom'] = userFrom!.toJson();
    }
    if (userTo != null) {
      data['userTo'] = userTo!.toJson();
    }
    data['dateTime'] = dateTime;
    data['owner'] = owner;
    data['new'] = NEW;
    return data;
  }
}

class UserFrom {
  String? username;
  String? fullName;

  UserFrom({this.username, this.fullName});

  UserFrom.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['fullName'] = fullName;
    return data;
  }
}

class Pageable {
  Sort? sort;
  num? offset;
  num? pageNumber;
  num? pageSize;
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.sort,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['offset'] = offset;
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['paged'] = paged;
    data['unpaged'] = unpaged;
    return data;
  }
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sorted'] = sorted;
    data['unsorted'] = unsorted;
    data['empty'] = empty;
    return data;
  }
}
