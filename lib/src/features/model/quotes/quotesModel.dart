class QuoteModel {
  final String quoteText;
  final String? quoteAuther;
  final String? quotesCategory;

  QuoteModel({required this.quoteText, this.quoteAuther, this.quotesCategory});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
        quoteText: json['text'] as String,
        quoteAuther: json['auther']  ?? "Unknown",
        quotesCategory: json['category'] ?? "Unknown");
  }
}
