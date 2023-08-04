import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/utilities/app_url.dart';

import 'WeatherModel/WeatherDataModel.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<WeatherDataModel> fetchWeather() async {
    final response = await http.get(Uri.parse(AppUrl.baseUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body.toString());
      return WeatherDataModel.fromJson(data);
    } else {
      throw Exception('Data could not be loaded..');
    }
  }

  late Future<WeatherDataModel> myWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF676BD0),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 30.0,
        ),
        child: Stack(
          children: [
            SafeArea(
                top: true,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('images/profile.jpeg'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: FutureBuilder<WeatherDataModel>(
                          future: myWeather,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data!.weather[0].main.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      letterSpacing: 1.3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '6 Aralık, 2023',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    height: 250,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage('images/cloud.png'),
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Sıcaklık',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            '${((snapshot.data!.main.temp - 32 * 5) / 9).toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 21,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Rüzgar',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              Text(
                                                '${snapshot.data!.wind.speed} km/h',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Nem',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${snapshot.data!.main.humidity}%',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 21,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {},
                                                child: Text(
                                                    'Haftalık Hava Durumunu Gör'),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors
                                                      .deepPurpleAccent[100],
                                                  minimumSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        1.1,
                                                    50,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text('Data could not be loaded...');
                            } else {
                              return CircularProgressIndicator(
                                color: Colors.white,
                              );
                            }
                          }),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
