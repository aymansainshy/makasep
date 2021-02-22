import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/massages_model.dart';

final _options = BaseOptions(
  baseUrl: "http://162.0.230.58/api",
  connectTimeout: 5000,
  receiveTimeout: 1000,
  headers: {
    'content-type': 'application/json',
    'Accept': 'application/json',
  },
);

Dio _dio = Dio(_options);

class MassagesProvider with ChangeNotifier {
  int _startChatId;
  List<UserChat> _userChats = [];

  List<UserChat> get userChat {
    return [..._userChats];
  }

  int get startChatId {
    return _startChatId;
  }

  List<ChatMassage> _chatMessages = [];

  List<ChatMassage> get chatMassages {
    return [..._chatMessages.reversed.toList()];
  }

  Future<void> fetchUserChat(String userId) async {
    try {
      final _response = await _dio.get("/chat/$userId");

      final _responsData = _response.data as List<dynamic>;
      List<UserChat> _loadedChats = [];
      _responsData.forEach((chat) {
        return _loadedChats.add(UserChat.fromJson(chat));
      });
      _userChats = _loadedChats;
      notifyListeners();
      print("Response Message ..... " + _userChats.toString());
    } catch (e) {
      print("Errror Message ..... " + e.toString());
      throw e.toString();
    }
  }

//////////////////////////////////[ChatMessages]///////////////////////////////////////////
  Future<void> fetchChatMessages(String chatId) async {
    try {
      final _response = await _dio.get("/message", queryParameters: {
        "chat_id": chatId,
      });

      final _responsData = _response.data as List<dynamic>;
      List<ChatMassage> _loadedMessage = [];

      _responsData.forEach((chat) {
        return _loadedMessage.add(ChatMassage.fromJson(chat));
      });

      _chatMessages = _loadedMessage;
      notifyListeners();
      print("Response chatMessage ..... " + _chatMessages.toString());
    } catch (e) {
      print("Errror Message ..... " + e.toString());
      throw e.toString();
    }
  }

//////////////////////////////////[Start Chat]///////////////////////////////////////////
  Future<void> startChat({String userId, String realEstateId}) async {
    try {
      final _response = await _dio.get("/chat/$userId/start",
          queryParameters: {"real_estate_id": realEstateId});

      final _responsData = _response.data["message"] as List<dynamic>;
      List<ChatMassage> _loadedMessage = [];
      _responsData.forEach((chat) {
        return _loadedMessage.add(ChatMassage.fromJson(chat));
      });
      _startChatId = _response.data["chat_id"];
      _chatMessages = _loadedMessage;
      notifyListeners();
      print("Response chatMessage ..... " + _chatMessages.toString());
    } catch (e) {
      print("Errror Message ..... " + e.toString());
      throw e.toString();
    }
  }

//////////////////////////////////[PostChat]///////////////////////////////////////////
  Future<void> postMessage({
    int senderId,
    int recieverId,
    int chatId,
    String content,
  }) async {
    final dataTime = DateTime.now();
    try {
      final newChatMassage = ChatMassage(
        id: dataTime.toIso8601String(),
        chatId: chatId.toString(),
        content: content,
        receiverId: recieverId.toString(),
        senderId: senderId.toString(),
      );

      _chatMessages.add(newChatMassage);
      notifyListeners();
      final _response = await _dio.post("/message", data: {
        "sender_id": senderId,
        "resiver_id": recieverId,
        "chat_id": chatId,
        "message": content,
      });

      print("Response Post ..... " + _response.data.toString());
    } catch (e) {
      print("Errror Message ..... " + e.toString());
      _chatMessages
          .removeWhere((massage) => massage.id == dataTime.toIso8601String());
      notifyListeners();
      throw e.toString();
    }
  }
}
