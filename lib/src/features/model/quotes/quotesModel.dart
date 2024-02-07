class QuoteModel {
  final String quoteId;
  final String quoteText;
  final String? quoteAuther;
  final String? quotesCategory;

  QuoteModel({required this.quoteId, required this.quoteText, this.quoteAuther, this.quotesCategory});

  // QuoteModel(this.quoteId, {required this.quoteText, this.quoteAuther, this.quotesCategory, required String quoteId});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
        quoteId: json['_id'] as String,
        quoteText: json['text'] as String,
        quoteAuther: json['auther']  ?? "Unknown",
        quotesCategory: json['category'] ?? "Unknown");
  }
}
