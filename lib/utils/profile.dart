import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:memoir/const.dart';
import 'package:memoir/models/user.dart';

class ProfileWidget extends StatelessWidget {
  CustomUser user;
  ProfileWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Stack(
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: primaryColor.withOpacity(0.6),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: user.image,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: user.status ? Colors.green : Colors.red),
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              user.username,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            Text(user.role,
                style: TextStyle(
                  color: Colors.grey,
                ))
          ],
        ),
        /*  Spacer(),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: user.status ? Colors.green : Colors.red),
          height: 20,
          width: 20,
        ),
        SizedBox(
          width: 10,
        )*/
      ],
    );
  }
}
