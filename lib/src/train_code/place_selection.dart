import 'package:flutter/material.dart';

class PlaceSelectionScreen extends StatelessWidget {
  final String title;
  final Function(String) onPlaceSelected;

  PlaceSelectionScreen({
    required this.title,
    required this.onPlaceSelected,
  });

  final List<String> places = [
    "서울역",
    "부산역",
    "대전역",
    "광주역",
    "대구역",
    "인천역",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(places[index]),
            onTap: () {
              onPlaceSelected(places[index]);
              Navigator.pop(context); // 선택 후 이전 화면으로 돌아가기
            },
          );
        },
      ),
    );
  }
}
