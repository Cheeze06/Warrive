import 'dart:convert'; // utf8과 jsonDecode 사용
import 'package:http/http.dart' as http;

class TrainAPI {
  static const String apiUrl =
      "https://apis.data.go.kr/1613000/TrainInfoService/getStrtpntAlocFndTrainInfo";
  static const String serviceKey =
      "om0pDKsS%2FyWxxcSKSNMvpg%2FtDfbr25yCx2FiManiEtKkDT8whQoehzUC0BMNcWvXQ50EdaB3p2RgpIol5frQ0w%3D%3D";

  Future<dynamic> fetchTrainInfo({
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

      if (response.statusCode == 200) {
        // 한글 깨짐 방지: UTF-8로 디코딩 후 JSON 디코딩
        final decodedBody = jsonDecode(utf8.decode(response.bodyBytes));
        return decodedBody; // JSON 데이터 반환
      } else {
        return "API 호출 실패: ${response.statusCode}";
      }
    } catch (e) {
      return "API 호출 중 오류 발생: $e";
    }
  }
}
