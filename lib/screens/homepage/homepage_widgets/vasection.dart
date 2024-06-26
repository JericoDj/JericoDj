import 'package:flutter/material.dart';

class VASection extends StatelessWidget {
  final List<String> vaNiches = [
    'General Social Media VA',
    'Customer Support VA',
    'Web/Mobile App VA',
    'E-commerce VA',
    'Bookkeeping VA',
    'Graphic Design VA',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('VA Niches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
            ),
            itemCount: vaNiches.length,
            itemBuilder: (context, index) {
              return VAContainer(niche: vaNiches[index]);
            },
          ),
        ],
      ),
    );
  }
}

class VAContainer extends StatelessWidget {
  final String niche;

  VAContainer({required this.niche});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          niche,
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
