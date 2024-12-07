import 'package:http/http.dart' as http;
import 'package:charset_converter/charset_converter.dart'; // CP949 디코딩을 위한 패키지

class TrainAPI {
  static const String apiUrl =
      "https://apis.data.go.kr/1613000/TrainInfoService/getStrtpntAlocFndTrainInfo";

  // 주어진 URL 인코딩된 서비스 키를 여기에 넣으세요.
  static const String serviceKey =
      "om0pDKsS%2FyWxxcSKSNMvpg%2FtDfbr25yCx2FiManiEtKkDT8whQoehzUC0BMNcWvXQ50EdaB3p2RgpIol5frQ0w%3D%3D";

  Future<String> fetchTrainInfo({
    required String depPlaceId,
    required String arrPlaceId,
    required String depPlandTime,
    String trainGradeCode = '00',
    int numOfRows = 10,
    int pageNo = 1,
  }) async {
    final String url =
        '$apiUrl?serviceKey=$serviceKey&depPlaceId=$depPlaceId&arrPlaceId=$arrPlaceId&depPlandTime=$depPlandTime&trainGradeCode=$trainGradeCode&numOfRows=$numOfRows&pageNo=$pageNo&_type=json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // 바이트 데이터를 CP949로 디코딩
        final decodedBody = await CharsetConverter.decode("euc-kr", response.bodyBytes);
        return decodedBody; // 디코딩된 문자열 반환
      } else {
        return "API 호출 실패: ${response.statusCode}";
      }
    } catch (e) {
      return "API 호출 중 오류 발생: $e";
    }
  }
}
