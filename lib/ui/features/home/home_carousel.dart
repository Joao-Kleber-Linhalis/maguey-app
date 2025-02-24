import 'package:flutter/material.dart';

import '../../../theme/my_icons.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

final List<Map<String, String>> imagePaths = [
  {
    'path': MyIcons.backgroudHomeIcon,
    'title': 'Mezcal',
  },
  {
    'path': MyIcons.backgroudHomeIcon2,
    'title': 'The Plant',
  },
  {
    'path': MyIcons.backgroudHomeIcon3,
    'title': 'The Process',
  },
  {
    'path': MyIcons.backgroudHomeIcon4,
    'title': 'The Pattern',
  },
];

late List<Widget> _pages;

int _activePage = 0;

final PageController _pageController = PageController(initialPage: 0); //Controlador para o PageView Builder, colocando a pagina inicial como 0.

class _HomeCarouselState extends State<HomeCarousel> {
  @override
  void initState() {
    super.initState();
    _pages = List.generate(
      imagePaths.length,
      (index) => ImagePlaceHolder(
        imagePath: imagePaths[index]['path'],
        title: imagePaths[index]['title'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              width: widthOfScreen * 0.929640,
              height: heightOfScreen * 0.444500,
              child: PageView.builder(
                controller: _pageController,
                itemCount: imagePaths.length,
                onPageChanged: (value) {
                  setState(() {
                    _activePage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: heightOfScreen * 0.0035),
                    child: _pages[index],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      _pages.length,
                      (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: heightOfScreen * 0.005833),
                            child: InkWell(
                              onTap: () {
                                _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                              },
                              child: CircleAvatar(
                                  radius: _activePage == index ? heightOfScreen * 0.007 : heightOfScreen * 0.004667,
                                  backgroundColor: const Color(0xFFE6E54A)),
                            ),
                          )),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class ImagePlaceHolder extends StatelessWidget {
  final String? imagePath;
  final String? title;
  const ImagePlaceHolder({super.key, this.imagePath, this.title});

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            imagePath!,
            width: widthOfScreen * 0.929640,
            height: heightOfScreen * 0.444500,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          bottom: 0,
          top: 0,
          right: 0,
          left: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title!,
                style: const TextStyle(
                  color: Color(0xFFE3FF0A),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
