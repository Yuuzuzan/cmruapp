import 'dart:convert';

import 'package:cmruapp/config/app.dart';
import 'package:cmruapp/services/auth_services.dart';
import 'package:cmruapp/services/page_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> banners = [];
  List<dynamic> pages = [];

  get loggedIn => null;

  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse('$API_URL/api/banners'));
      final banners = jsonDecode(response.body);
      print(banners);
      setState(() {
        this.banners = banners;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPages() async {
    try {
      List<dynamic> pages = await PageServices.fetchPages();
      setState(() {
        this.pages = pages;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    AuthServices.checkLoglin().then((loggedIn) {
      if (loggedIn) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    fetchBanners();
    fetchPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Swiper(
              autoplay: true,
              itemCount: banners.length,
              itemBuilder: (context, index) {
                return Image.network(
                  '$API_URL/${banners[index]['imageUrl']}',
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
