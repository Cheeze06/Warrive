// lib/src/train_code/TrainAPI.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainAPI {
  static const String apiUrl =
      "https://apis.data.go.kr/1613000/TrainInfoService/getStrtpntAlocFndTrainInfo";

  static const String serviceKey =
      "om0pDKsS%2FyWxxcSKSNMvpg%2FtDfbr25yCx2FiManiEtKkDT8whQoehzUC0BMNcWvXQ50EdaB3p2RgpIol5frQ0w%3D%3D"; // URL 인코딩된 키

  // URL을 템플릿으로 정의하고, 값을 받아서 대입
  Future<Map<String, String>> fetchTrainInfo({
    required String depPlaceId,
    required String arrPlaceId,
    required String depPlandTime,
    String trainGradeCode = '00',
    int numOfRows = 10,
    int pageNo = 1,
  }) async {
    // URL에 필요한 값들을 대입한 새로운 URL 생성
    final String url = '$apiUrl?serviceKey=$serviceKey&depPlaceId=$depPlaceId&arrPlaceId=$arrPlaceId&depPlandTime=$depPlandTime'
        '&trainGradeCode=$trainGradeCode&numOfRows=$numOfRows&pageNo=$pageNo&_type=json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return _extractRelevantInfo(data);
      } else {
        return {"error": "API 호출 실패: ${response.statusCode}"};
      }
    } catch (e) {
      return {"error": "API 호출 중 오류 발생: $e"};
    }
  }

  // 필요한 값만 추출하여 반환하는 함수
  Map<String, String> _extractRelevantInfo(Map<String, dynamic> data) {
    final result = <String, String>{};

    try {
      // 열차 정보 추출
      final trainInfo = data['response']['body']['items']['item'] ?? [];

      if (trainInfo.isNotEmpty) {
        // 첫 번째 열차 정보만 추출
        final firstTrain = trainInfo[0];

        final arrPlaceName = firstTrain['arrPlaceName'] ?? '정보 없음';
        final depPlaceName = firstTrain['depPlaceName'] ?? '정보 없음';
        final arrPlandTime = firstTrain['arrPlandTime'] ?? '';
        final depPlandTime = firstTrain['depPlandTime'] ?? '';
        final trainGradeName = firstTrain['trainGradeName'] ?? '정보 없음';

        // arrPlandTime, depPlandTime에서 날짜 부분을 제거하고 시간, 분, 초만 남기기
        final arrTime = arrPlandTime.isNotEmpty ? arrPlandTime.substring(8) : '정보 없음';
        final depTime = depPlandTime.isNotEmpty ? depPlandTime.substring(8) : '정보 없음';

        // 필요한 정보만 결과에 저장
        result['arrPlaceName'] = arrPlaceName;
        result['arrPlandTime'] = arrTime;  // 시간:분:초
        result['depPlaceName'] = depPlaceName;
        result['depPlandTime'] = depTime;  // 시간:분:초
        result['trainGradeName'] = trainGradeName;
      }
    } catch (e) {
      result['error'] = '데이터 처리 중 오류 발생: $e';
    }

    return result;
  }
}
