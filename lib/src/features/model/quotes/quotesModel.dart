

class QuoteModel {
  final String quoteText;
  final String? quoteAuther;

  QuoteModel({required this.quoteText, this.quoteAuther});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(quoteText: json['text'] as String,
     quoteAuther: json['author'] as String? ?? "Unknown");
  }
}

