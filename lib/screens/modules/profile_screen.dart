// ignore_for_file: prefer_const_constructors

import 'package:first_task_1/core/controllers/profile_cubit/profile_cubit.dart';
import 'package:first_task_1/core/controllers/profile_cubit/profile_states.dart';
import 'package:first_task_1/core/managers/nav.dart';
import 'package:first_task_1/core/managers/values.dart';
import 'package:first_task_1/core/network/local/cache_helper.dart';
import 'package:first_task_1/screens/modules/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        if (state is LoadingProfile) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileDone || state is EditingProfile) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              actions: [
                if (state is ProfileDone)
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Start editing the profile
                      cubit.startEditingProfile();
                    },
                  ),
                if (state is EditingProfile)
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          // Check if any changes were made
                          if (_changesMade(cubit)) {
                            // Save changes and update the user profile
                            cubit.updateUserProfile(
                              name: cubit.nameController.text,
                              email: cubit.emailController.text,
                              phone: cubit.phoneController.text,
                            );
                          } else {
                            // No changes made, just cancel the editing state
                            cubit.cancelEditingProfile();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          // Cancel the edit and revert to the original data
                          cubit.cancelEditingProfile();
                        },
                      ),
                    ],
                  ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    // Handle logout
                    CacheHelper.removeData(key: 'token');
                    CacheHelper.removeData(key: 'userId');
                    navigateAndFinishThisScreen(
                        context, const OnboardingScreen());
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Hero animation for the profile image
                    space,
                    space,
                    space,

                    Hero(
                      tag: 'profileImage',
                      child: CircleAvatar(
                        radius: 55.0,
                        backgroundColor: Colors.white,
                        backgroundImage: cubit.userModel?.user?.profileImage !=
                                null
                            ? NetworkImage(cubit.userModel!.user!.profileImage!)
                            : Image.network(
                                "https://www.kindpng.com/picc/m/399-3991684_transparent-kawaii-coffee-png-cute-coffee-cup-clipart.png",
                                fit: BoxFit.cover,
                              ).image,
                      ),
                    ),
                    space,
                    space,
                    space,
                    space,
                    if (state is EditingProfile)
                      _buildAnimatedTextField(
                        //  initialValue: cubit.userModel!.user!.name!,
                        controller: cubit.nameController,
                        //  labelText: 'Name',
                        icon: Icons.person,
                      )
                    else
                      _buildInfoRow(cubit.userModel?.user?.name, Icons.person),
                    //const SizedBox(height: 10),
                    const SizedBox(height: 30),
                    if (state is EditingProfile)
                      _buildAnimatedTextField(
                        //    initialValue: cubit.userModel?.user?.email ?? '',
                        controller: cubit.emailController,
                        //   labelText: 'Email',
                        icon: Icons.email,
                      )
                    else
                      _buildInfoRow(cubit.userModel?.user?.email, Icons.email),
                    const SizedBox(height: 30),
                    if (state is EditingProfile)
                      _buildAnimatedTextField(
                        //    initialValue: cubit.userModel?.user?.phone ?? '',
                        controller: cubit.phoneController,
                        //    labelText: 'Phone',
                        icon: Icons.phone,
                      )
                    else
                      _buildInfoRow(cubit.userModel?.user?.phone, Icons.phone),
                  ],
                ),
              ),
            ),
          );
        } else if (state is ErrorProfile) {
          return const Center(child: Text('Error loading profile.'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  bool _changesMade(ProfileCubit cubit) {
    final userModel = cubit.userModel!.user!;
    return userModel.name != cubit.nameController.text ||
        userModel.email != cubit.emailController.text ||
        userModel.phone != cubit.phoneController.text;
  }

  Widget _buildInfoRow(String? value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: metal,
          size: 24.0,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(' ${value ?? ''}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'NeusaNextStd',
              color: Color.fromARGB(146, 84, 52, 105),
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            )),
      ],
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    //  required String labelText,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        style: TextStyle(fontFamily: 'NeusaNextStd', fontSize: 15),
        controller: controller,
        decoration: InputDecoration(
          //  labelText: labelText,

          floatingLabelBehavior: FloatingLabelBehavior.always,
          icon: Icon(icon, color: const Color.fromARGB(255, 65, 55, 90)),
        ),
      ),
    );
  }
}
