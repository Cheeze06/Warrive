// lib/main.dart
import 'package:flutter/material.dart';
import 'src/train_code/API_return.dart'; // API 호출 클래스 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrainInfoScreen(),
    );
  }
}

class TrainInfoScreen extends StatefulWidget {
  @override
  _TrainInfoScreenState createState() => _TrainInfoScreenState();
}

class _TrainInfoScreenState extends State<TrainInfoScreen> {
  final TrainAPI trainAPI = TrainAPI();
  String result = "결과가 여기에 표시됩니다.";

  // API 호출 함수 (Future<void>로 반환 타입 수정)
  Future<void> fetchTrainData() async {
    const depPlaceId = 'NAT010000'; // 서울역 코드
    const arrPlaceId = 'NAT011668'; // 부산역 코드
    const depPlandTime = '20241124'; // 출발 날짜 (예: 2024년 11월 24일)

    // API 호출 후 결과 처리
    final data = await trainAPI.fetchTrainInfo(
      depPlaceId: depPlaceId,
      arrPlaceId: arrPlaceId,
      depPlandTime: depPlandTime,
    );

    setState(() {
      if (data.isNotEmpty && !data.containsKey('error')) {
        result = "출발역: ${data['depPlaceName']} (${data['depPlandTime']} 출발 예정)\n"
            "도착역: ${data['arrPlaceName']} (${data['arrPlandTime']} 도착 예정)\n"
            "기차 종류: ${data['trainGradeName']}";
      } else {
        result = data['error'] ?? "데이터를 가져오지 못했습니다.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Train Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: fetchTrainData, // 버튼 클릭 시 API 호출
              child: const Text('열차 정보 가져오기'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(result, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
