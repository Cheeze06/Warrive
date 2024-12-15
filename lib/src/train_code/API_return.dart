import 'dart:convert'; // utf8과 jsonDecode 사용
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'API_vo.dart';

class TrainAPI {
  static const String apiUrl =
      "https://apis.data.go.kr/1613000/TrainInfoService/getStrtpntAlocFndTrainInfo";
  static const String serviceKey =
      "om0pDKsS%2FyWxxcSKSNMvpg%2FtDfbr25yCx2FiManiEtKkDT8whQoehzUC0BMNcWvXQ50EdaB3p2RgpIol5frQ0w%3D%3D";

  Future<TrainResponse?> fetchTrainInfo({
    required String depPlaceId,
    required String arrPlaceId,
    required String depPlandTime,
    String trainGradeCode = '00',
    int numOfRows = 10,
    int pageNo = 1,
  }) async {
    final String url =
        '$apiUrl?serviceKey=$serviceKey&depPlaceId=$depPlaceId&arrPlaceId=$arrPlaceId&depPlandTime=$depPlandTime'
        '&trainGradeCode=$trainGradeCode&numOfRows=$numOfRows&pageNo=$pageNo&_type=json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        return null;
      }

      // 한글 깨짐 방지: UTF-8로 디코딩 후 JSON 디코딩
      final decodedBody = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint("API 응답: $decodedBody"); // 디버깅용 응답 출력

      if (decodedBody is Map<String, dynamic>) {
        final vo = TrainResponse.fromJson(decodedBody);
        return vo;
      } else {
        debugPrint("예상치 못한 응답 형식: $decodedBody");
        return null;
      }
    } catch (e) {
      debugPrint("API 호출 중 오류 발생: $e");
      return null;
    }
  }

}
