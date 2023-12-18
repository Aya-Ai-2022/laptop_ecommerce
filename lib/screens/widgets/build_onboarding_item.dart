import 'package:first_task_1/models/onboarding.dart';
import 'package:flutter/material.dart';

Widget buildOnBoardingItem(OnBoardingModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: Image(
              image: AssetImage(model.image!),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.title!,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.subtitle!,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          )
        ],
      ),
    );
