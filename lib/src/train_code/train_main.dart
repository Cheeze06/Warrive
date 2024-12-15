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

  String selectedDepPlace = "출발역 선택"; // 선택된 출발역 이름
  String selectedArrPlace = "도착역 선택"; // 선택된 도착역 이름

  String? selectedDepPlaceId; // 출발역 ID
  String? selectedArrPlaceId; // 도착역 ID

  Future<void> fetchTrainData() async {
    if (selectedDepPlaceId == null || selectedArrPlaceId == null) {
      setState(() {
        result = "출발역과 도착역을 모두 선택하세요.";
      });
      return;
    }

    final DateTime now = DateTime.now();
    final String depPlandTime =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";

    final data = await trainAPI.fetchTrainInfo(
      depPlaceId: selectedDepPlaceId!,
      arrPlaceId: selectedArrPlaceId!,
      depPlandTime: depPlandTime,
    );

    setState(() {
      result = data != null ? data.toString() : "데이터를 가져오지 못했습니다.";
    });
  }

  void navigateToSelectDepPlace() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceSelectionScreen(
          title: "출발역 선택",
          onPlaceSelected: (placeName, placeId) {
            setState(() {
              selectedDepPlace = placeName; // 역 이름
              selectedDepPlaceId = placeId; // 역 ID
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
          onPlaceSelected: (placeName, placeId) {
            setState(() {
              selectedArrPlace = placeName; // 역 이름
              selectedArrPlaceId = placeId; // 역 ID
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
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      textStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(selectedDepPlace, textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: navigateToSelectArrPlace,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      textStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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
