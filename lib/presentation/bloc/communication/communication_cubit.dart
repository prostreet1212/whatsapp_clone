import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/app_const.dart';
import 'package:whatsapp_clone/domain/entities/my_chat_entity.dart';
import '../../../domain/entities/text_message_entity.dart';
import '../../../domain/usecases/add_to_my_chat_usecase.dart';
import '../../../domain/usecases/get_one_to_one_single_user_chat_channel_usecase.dart';
import '../../../domain/usecases/get_text_messages_usecase.dart';
import '../../../domain/usecases/send_text_message_usecase.dart';

part 'communication_state.dart';

class CommunicationCubit extends Cubit<CommunicationState> {
  final SendTextMessageUseCase sendTextMessagesUseCase;
  final GetOneToOneSingleUserChatChannelUseCase
      getOneToOneSingleUserChatChannelUseCase;
  final GetTextMessagesUseCase getTextMessagesUseCase;
  final AddToMyChatUseCase addToMyChatUseCase;

  CommunicationCubit(
      {required this.sendTextMessagesUseCase,
      required this.getOneToOneSingleUserChatChannelUseCase,
      required this.getTextMessagesUseCase,
      required this.addToMyChatUseCase})
      : super(CommunicationInitial());

  Future<void> sendTextMessage({
    required String senderName,
    required String senderId,
    required String recipientId,
    required String recipientName,
    required String message,
    required String recipientPhoneNumber,
    required String senderPhoneNumber,
  }) async {
    try {
      final channelId = await getOneToOneSingleUserChatChannelUseCase.call(
          senderId, recipientId);
      await sendTextMessagesUseCase.call(
          TextMessageEntity(
            senderName: senderName,
            sederUID: senderId,
            recipientName: recipientName,
            recipientUID: recipientId,
            messsageType: AppConst.oneToOneChat,
            message: message,
            messageId: '',
            time: Timestamp.now(),
          ),
          channelId);
      await addToMyChatUseCase.call(MyChatEntity(
        time: Timestamp.now(),
        senderName: senderName,
        senderUID: senderId,
        senderPhoneNumber: senderPhoneNumber,
        recipientName: recipientName,
        recipientUID: recipientId,
        recipientPhoneNumber: recipientPhoneNumber,
        recentTextMessage: message,
        profileURL: "",
        isRead: true,
        isArchived: false,
        channelId: channelId,
      ));
    } on SocketException catch (_) {
      emit(CommunicationFailure());
    } catch (_) {
      emit(CommunicationFailure());
    }
  }

  Future<void> getMessages(
      {required String senderId, required String recipientId}) async {
    emit(CommunicationLoading());
    try {
      final channelId = await getOneToOneSingleUserChatChannelUseCase.call(
          senderId, recipientId);
      final messagesStreamData = getTextMessagesUseCase.call(channelId);
      messagesStreamData.listen((messages) {
        emit(CommunicationLoaded(messages: messages));
      });
    } on SocketException catch (_) {
      emit(CommunicationFailure());
    } catch (_) {
      emit(CommunicationFailure());
    }
  }
}
