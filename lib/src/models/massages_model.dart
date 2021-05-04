class UserChat {
  final int chatId;
  final int realEstateId;
  final String realEsateTypeId;
  final String realEstateCatId;
  final String realEstateImageUrl;

  UserChat({
    this.chatId,
    this.realEstateId,
    this.realEstateImageUrl,
    this.realEsateTypeId,
    this.realEstateCatId,
  });

  factory UserChat.fromJson(Map<String, dynamic> json) {
    return UserChat(
      chatId: json["id"],
      realEstateId: json["real_estate"]["id"],
      realEsateTypeId: json["real_estate"]["secondry_type_id"],
      realEstateCatId: json["real_estate"]["primary_type_id"],
      realEstateImageUrl: "http://162.0.230.58/" + json["real_estate"]["image"],
    );
  }
}

class ChatMassage {
  final String id;
  final String chatId;
  final String senderId;
  final String receiverId;
  final String content;

  ChatMassage({
    this.id,
    this.chatId,
    this.senderId,
    this.receiverId,
    this.content,
  });

  factory ChatMassage.fromJson(Map<String, dynamic> json) {
    return ChatMassage(
      id: json["id"].toString(),
      senderId: json["sender_id"],
      receiverId: json["resiver_id"],
      chatId: json["chat_id"],
      content: json["message"],
    );
  }
}
