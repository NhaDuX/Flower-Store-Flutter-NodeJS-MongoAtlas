import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableCarousel extends StatefulWidget {
  final List<String> imageList;

  ReusableCarousel({required this.imageList});

  @override
  _ReusableCarouselState createState() => _ReusableCarouselState();
}

class _ReusableCarouselState extends State<ReusableCarousel> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imageList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(2.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item, fit: BoxFit.fill,)),
              ),
            ))
        .toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Column(
        children: [
          CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imageList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: _current == entry.key ? 20.0 : 20.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: _current == entry.key
                        ? Color(0xfff56789)
                        : Colors.white,
                    border: Border.all(color: Colors.black54, width: 1.0),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}