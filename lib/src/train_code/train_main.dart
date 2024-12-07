import 'package:flutter/material.dart';
import 'API_return.dart'; // TrainAPI 클래스 import
import 'place_selection.dart'; // 역 선택 화면 import

class TrainInfoScreen extends StatefulWidget {
  @override
  _TrainInfoScreenState createState() => _TrainInfoScreenState();
}

class _TrainInfoScreenState extends State<TrainInfoScreen> {
  final TrainAPI trainAPI = TrainAPI();
  String result = "결과가 여기에 표시됩니다.";
  String selectedDepPlace = "출발역 선택"; // 출발역 이름
  String selectedArrPlace = "도착역 선택"; // 도착역 이름

  Future<void> fetchTrainData() async {
    const depPlaceId = 'NAT010000'; // 서울역 코드
    const arrPlaceId = 'NAT011668'; // 부산역 코드
    final DateTime now = DateTime.now();
    final String depPlandTime =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";

    final data = await trainAPI.fetchTrainInfo(
      depPlaceId: depPlaceId,
      arrPlaceId: arrPlaceId,
      depPlandTime: depPlandTime,
    );

    setState(() {
      if (data != null) {
        result = data.toString();
      } else {
        result = "데이터를 가져오지 못했습니다.";
      }
    });
  }

  void navigateToSelectDepPlace() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceSelectionScreen(
          title: "출발역 선택",
          onPlaceSelected: (place) {
            setState(() {
              selectedDepPlace = place;
            });
          },
        ),
      ),
    );
  }

  void navigateToSelectArrPlace() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceSelectionScreen(
          title: "도착역 선택",
          onPlaceSelected: (place) {
            setState(() {
              selectedArrPlace = place;
            });
          },
        ),
      ),
    );
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: navigateToSelectDepPlace,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 25), // 높이 설정
                      textStyle: const TextStyle(fontSize: 20), // 텍스트 크기 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게
                      ),
                    ),
                    child: Text(selectedDepPlace, textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(width: 10), // 버튼 간 간격
                Expanded(
                  child: ElevatedButton(
                    onPressed: navigateToSelectArrPlace,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 25), // 높이 설정
                      textStyle: const TextStyle(fontSize: 20), // 텍스트 크기 설정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게
                      ),
                    ),
                    child: Text(selectedArrPlace, textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchTrainData,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15), // 높이 설정
                textStyle: const TextStyle(fontSize: 18), // 텍스트 크기 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게
                ),
              ),
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
