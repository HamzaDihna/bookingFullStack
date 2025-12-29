class RatingModel {
  final String? id; // أضفته لأنه غالباً يأتي من السيرفر ومفيد للتعامل مع البيانات
  final double stars;
  final String? comment;
  final DateTime createdAt;

  RatingModel({
    this.id,
    required this.stars,
    this.comment,
    required this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      // تأكد أن الأسماء بين القوسين [' '] تطابق ما يرسله Laravel
      id: json['id']?.toString(),
      
      // نستخدم double.parse لأن السيرفر قد يرسل الرقم كنص أو int
      stars: double.parse(json['rating'].toString()), 
      
      comment: json['comment'],
      
      // تحويل النص القادم من السيرفر إلى DateTime
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(), 
    );
  }
}