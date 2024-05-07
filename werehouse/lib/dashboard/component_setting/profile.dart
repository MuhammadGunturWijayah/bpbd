import 'package:flutter/material.dart';
import 'package:werehouse/dashboard/component_setting/constants.dart';
import 'package:werehouse/dashboard/component_setting/profile_setting.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.06),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 150,
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: ExactAssetImage('assets/images/profile.jpg'),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Constants.primaryColor.withOpacity(.5),
                      width: 5.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'John Doe',
                style: TextStyle(
                  color: Constants.blackColor,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'johndoe@gmail.com',
                style: TextStyle(
                  color: Constants.blackColor.withOpacity(.3),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  ProfileWidget(
                    icon: Icons.person,
                    title: 'My Profile',
                  ),
                  ProfileWidget(
                    icon: Icons.settings,
                    title: 'Settings',
                  ),
                  ProfileWidget(
                    icon: Icons.notifications,
                    title: 'Notifications',
                  ),
                  ProfileWidget(
                    icon: Icons.chat,
                    title: 'FAQs',
                  ),
                  ProfileWidget(
                    icon: Icons.share,
                    title: 'Share',
                  ),
                  ProfileWidget(
                    icon: Icons.logout,
                    title: 'Log Out',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
