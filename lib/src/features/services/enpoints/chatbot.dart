class ChatBotApi {
  final String apiKey = "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";
  final String url =
      'https://api.openai.com/v1/engines/gpt-3.5-turbo/completions';

  sendRequest(String message) {
    final headers = {
      'Content-Type: application/json',
      'Authorization: Bearer $apiKey'
    };
  }
}
