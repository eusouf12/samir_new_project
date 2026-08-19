class ContentFilterHelper {
  // Common list of objectionable / abusive / harassing keywords
  static final List<String> _objectionableWords = [
    'abuse',
    'hate',
    'kill',
    'die',
    'scam',
    'fraud',
    'fuck',
    'shit',
    'bitch',
    'bastard',
    'asshole',
    'dick',
    'pussy',
    'cunt',
    'nigger',
    'faggot',
    'porn',
    'nude',
    'naked',
    'sex',
    'rape',
    'whore',
    'slut',
  ];

  /// Checks if the text contains objectionable content.
  static bool containsObjectionableContent(String text) {
    if (text.isEmpty) return false;
    final lower = text.toLowerCase();
    for (final word in _objectionableWords) {
      final regex = RegExp(r'\b' + RegExp.escape(word) + r'\b', caseSensitive: false);
      if (regex.hasMatch(lower)) {
        return true;
      }
    }
    return false;
  }

  /// Sanitizes text by masking objectionable words.
  static String maskObjectionableContent(String text) {
    if (text.isEmpty) return text;
    String sanitized = text;
    for (final word in _objectionableWords) {
      final regex = RegExp(r'\b' + RegExp.escape(word) + r'\b', caseSensitive: false);
      sanitized = sanitized.replaceAllMapped(regex, (match) => '*' * word.length);
    }
    return sanitized;
  }
}
