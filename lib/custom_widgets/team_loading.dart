import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


/// This Widget uses the Shimmer dependency that is shown during the loading state for teams
/// The layout of thi Shimmer is the same as how teams appear when loaded

class TeamsLoading extends StatelessWidget {
  const TeamsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1500),
      baseColor: Colors.grey[300]!,
      highlightColor: const Color(0xFFF4F4F4),
      child: GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8
          ),
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1.5
                    )
                ),
            );
          }
      )
    );
  }
}