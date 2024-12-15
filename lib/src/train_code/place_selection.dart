import 'package:flutter/material.dart';

class PlaceSelectionScreen extends StatelessWidget {
  final String title;
  final Function(String, String) onPlaceSelected; // 역 이름과 ID 전달

  PlaceSelectionScreen({
    required this.title,
    required this.onPlaceSelected,
  });

  final Map<String, String> places = {
    '서울역': 'NAT010000',
    '부산역': 'NAT014445',
    '대전역': 'NAT011668',
    '김천역': 'NAT012546',
    '동대구역': 'NAT013271',
    '용산역': 'NAT010032',
  };

  @override
  Widget build(BuildContext context) {
    final placeEntries = places.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: placeEntries.length,
        itemBuilder: (context, index) {
          final placeName = placeEntries[index].key;
          final placeId = placeEntries[index].value;

          return ListTile(
            title: Text(placeName),
            onTap: () {
              onPlaceSelected(placeName, placeId); // 이름과 ID를 반환
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
