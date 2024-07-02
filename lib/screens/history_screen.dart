import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'my_game_screen.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              if (index == 4) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/h5.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Positioned(
                      top: 500,
                      left: 160,
                      child: Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.redAccent,
                          child: GestureDetector(
                            child: Center(
                                child: Text(
                              'REVENGE',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MyGameScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  child: Image.asset(
                    'assets/images/h${index + 1}.png',
                    width: double.infinity,
                    height: double.infinity,
                  ),
                );
              }
            },
            itemCount: 5,
            autoplay: false,
            loop: false,
            pagination: const SwiperPagination(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
              builder: DotSwiperPaginationBuilder(
                color: Colors.white30,
                activeColor: Colors.white,
                size: 20.0,
                activeSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
