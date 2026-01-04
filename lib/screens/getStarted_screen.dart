import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

            Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.68,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                   child: Image.asset(
                  
                    'assets/images/leohoho-MCDtGUwHD7M-unsplash.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                bottom: 430,
                left: 100,
                child: Image.asset(
                  'assets/images/Maskany logo-01.png', 
                  width: 150,
                ),
                
              ),
            ],
          ),

          const SizedBox(height: 20),

           Text(
            'Welcome!'.tr,
            style: TextStyle(
              fontSize: 55,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontFamily: 'DegularText-ThinItalic',
            ),
          ),

          const SizedBox(height: 8),

           Text(
            'Discover, Choose, Book'.tr,
            style: TextStyle(fontSize: 20),
          ),

           Text(
            'All In One Place'.tr,
            style: TextStyle(fontSize: 20),
          ),

          const SizedBox(height: 15),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              minimumSize: const Size(280, 50),
              shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
            ),
            onPressed: () {
              Get.toNamed('/login');
            },
            child:  Text('Get started'.tr, style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
