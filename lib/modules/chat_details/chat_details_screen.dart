import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel userModel;
  ChatDetailsScreen({this.userModel});
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      SocialCubit.get(context).getMessages(receiverId: userModel.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${userModel.image}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('${userModel.name}'),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var message =
                              SocialCubit.get(context).messages[index];
                          if (SocialCubit.get(context).userModel.uId ==
                              message.senderId) {
                            return buildMyMessage(message);
                          }
                          return buildMessage(message);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                        itemCount: SocialCubit.get(context).messages.length),
                  ),
                  // Spacer(),
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300], width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...'),
                            ),
                          ),
                          Container(
                            color: defaultColor,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text);
                              },
                              child: Icon(
                                IconBroken.Send,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //
            // ConditionalBuilder(
            //   // condition: SocialCubit.get(context).messages.length > 0,
            //   condition: true,
            //   builder: (context) => Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: Column(
            //       children: [
            //         Expanded(
            //           child: ListView.separated(
            //               itemBuilder: (context, index) {
            //                 var message =
            //                     SocialCubit.get(context).messages[index];
            //                 if (SocialCubit.get(context).userModel.uId ==
            //                     message.senderId) {
            //                   return buildMyMessage(message);
            //                 } else {
            //                   return buildMessage(message);
            //                 }
            //               },
            //               separatorBuilder: (context, index) => SizedBox(
            //                     height: 15,
            //                   ),
            //               itemCount: SocialCubit.get(context).messages.length),
            //         ),
            //         Spacer(),
            //         Container(
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 border:
            //                     Border.all(color: Colors.grey[300], width: 1),
            //                 borderRadius: BorderRadius.circular(10)),
            //             clipBehavior: Clip.antiAliasWithSaveLayer,
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   child: TextFormField(
            //                     controller: messageController,
            //                     decoration: InputDecoration(
            //                         border: InputBorder.none,
            //                         hintText: 'type your message here ...'),
            //                   ),
            //                 ),
            //                 Container(
            //                   color: defaultColor,
            //                   child: MaterialButton(
            //                     onPressed: () {
            //                       SocialCubit.get(context).sendMessage(
            //                           receiverId: userModel.uId,
            //                           dateTime: DateTime.now().toString(),
            //                           text: messageController.text);
            //                     },
            //                     child: Icon(
            //                       IconBroken.Send,
            //                       size: 16,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   fallback: (context) => Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(10),
                bottomEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
              )),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text('${model.text}'),
        ),
      );
  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(.3),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
              )),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text('${model.text}'),
        ),
      );
}
