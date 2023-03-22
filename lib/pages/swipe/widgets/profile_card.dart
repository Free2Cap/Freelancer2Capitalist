import 'package:flutter/material.dart';
import '../model/profile.dart';
import 'dart:developer';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.profile, required this.userType})
      : super(key: key);
  final dynamic profile;
  final String userType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      width: 340,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                userType == 'Investor'
                    ? profile!.projectImages
                    : profile!.firmImages,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 200,
              width: 340,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userType == 'Investor'
                          ? 'Aim: ${profile!.aim}'
                          : 'Name: ${profile!.name}',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Budget: ${profile!.budgetStart} - ${profile!.budgetEnd}',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromARGB(255, 67, 67, 67),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userType == 'Investor'
                          ? 'Objective: ${profile!.objective}'
                          : 'mission: ${profile!.mission}',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromARGB(255, 67, 67, 67),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Field: ${profile!.field}',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromARGB(255, 67, 67, 67),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Creator: ${profile!.creator}',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromARGB(255, 67, 67, 67),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
