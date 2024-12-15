class TrainResponse {
  final List<TrainItem> items;

  TrainResponse({required this.items});

  factory TrainResponse.fromJson(Map<String, dynamic> json) {
    final body = json['response']['body'];
    final items = body['items']['item'] as List<dynamic>;

    return TrainResponse(
      items: items.map((item) => TrainItem.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  String formatTrainInfo() {
    return items
        .map((item) =>
    "${item.depPlaceName} → ${item.arrPlaceName} ( 출발시간: ${item.depPlanTime.hour.toString().padLeft(2, '0')}:${item.depPlanTime.minute.toString().padLeft(2, '0')} )")
        .join("\n");
  }
}

class ResponseHeader {
  final String resultCode;
  final String resultMsg;

  ResponseHeader({required this.resultCode, required this.resultMsg});

  factory ResponseHeader.fromJson(Map<String, dynamic> json) {
    return ResponseHeader(
      resultCode: json['resultCode'] as String,
      resultMsg: json['resultMsg'] as String,
    );
  }
}

class ResponseBody {
  final List<TrainItem> items;
  final int numOfRows;
  final int pageNo;
  final int totalCount;

  ResponseBody({
    required this.items,
    required this.numOfRows,
    required this.pageNo,
    required this.totalCount,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) {
    return ResponseBody(
      items: (json['items']['item'] as List)
          .map((item) => TrainItem.fromJson(item))
          .toList(),
      numOfRows: json['numOfRows'] as int,
      pageNo: json['pageNo'] as int,
      totalCount: json['totalCount'] as int,
    );
  }
}

class TrainItem {
  final String arrPlaceName;
  final DateTime arrPlanTime;
  final String depPlaceName;
  final DateTime depPlanTime;
  final String trainGradeName;

  TrainItem({
    required this.arrPlaceName,
    required this.arrPlanTime,
    required this.depPlaceName,
    required this.depPlanTime,
    required this.trainGradeName,
  });

  factory TrainItem.fromJson(Map<String, dynamic> json) {
    return TrainItem(
      arrPlaceName: json['arrplacename'] as String,
      arrPlanTime: DateTime.parse(json['arrplandtime'] as String),
      depPlaceName: json['depplacename'] as String,
      depPlanTime: DateTime.parse(json['depplandtime'] as String),
      trainGradeName: json['traingradename'] as String,
    );
  }
}
