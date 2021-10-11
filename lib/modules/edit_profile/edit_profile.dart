import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/shared/component/component.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            defaultTextButton(
                function: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                text: 'Update'),
            SizedBox(
              width: 15,
            ),
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUpdateProfileLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 15),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(
                                              '${userModel.cover}',
                                            )
                                          : FileImage(coverImage),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    }),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 16,
                                  ),
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must be not empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User1),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'bio must be not empty';
                        }
                        return null;
                      },
                      label: 'BIO',
                      prefix: IconBroken.Info_Circle),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.number,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'phone must be not empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Calling),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
