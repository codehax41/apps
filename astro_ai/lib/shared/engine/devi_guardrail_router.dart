// shared/engine/devi_guardrail_router.dart
// AstroAI OS v4.0 - Global Devi AI Astrologer Strict 3-Layer Guardrail Engine

enum GuardrailStatus {
  allowed,
  blockedCoding,
  blockedFinancialAdvice,
  blockedSurveillance
}

class GuardrailEvaluation {
  final GuardrailStatus status;
  final bool isAllowed;
  final String? enforcedResponse;
  final String? domainCategory;
  String get category => domainCategory ?? "";

  const GuardrailEvaluation({
    required this.status,
    required this.isAllowed,
    this.enforcedResponse,
    this.domainCategory,
  });

  factory GuardrailEvaluation.allowed(String category) {
    return GuardrailEvaluation(
      status: GuardrailStatus.allowed,
      isAllowed: true,
      domainCategory: category,
    );
  }

  factory GuardrailEvaluation.blocked(GuardrailStatus status, String response) {
    return GuardrailEvaluation(
      status: status,
      isAllowed: false,
      enforcedResponse: response,
    );
  }
}

class DeviGuardrailRouter {
  static const String refusalCoding =
      "Your exalted Mercury loves clean logic, Ramsundar, but I only decode the celestial source code of the stars—not programming syntax or software bugs! Ask me instead which planetary hour (Mercury Hora) is best for your deep focus work today.";

  static const String refusalFinancial =
      "I can map how Jupiter and Saturn influence your 2nd and 11th houses of wealth cycles and financial discipline, but I never provide stock picks, crypto predictions, or regulated investment advice. Shall we look at your upcoming Dhana Yoga abundance periods instead?";

  static const String refusalSurveillance =
      "Cosmic ethics bind me strictly to your own sky. I cannot spy into another person's private karma or third-party life. Let's focus on how your own 7th and 10th house placements empower you to respond to this situation.";

  static final RegExp _codingPattern = RegExp(
    r'\b(code|coding|python|javascript|flutter|react|sql|query|algorithm|debug|debugging|syntax|compiler|math homework|system architecture|class |def |function|git commit)\b',
    caseSensitive: false,
  );

  static final RegExp _financialPattern = RegExp(
    r'\b(stock|stocks|crypto|bitcoin|ethereum|btc|eth|nifty|sensex|options trading|call option|put option|buy target|price target|mutual fund|invest in)\b',
    caseSensitive: false,
  );

  static final RegExp _surveillancePattern = RegExp(
    r'\b(spy|spying|is he cheating|is she cheating|what is .* doing|track my ex|who is she seeing|who is he seeing|secret lover|affair|private life)\b',
    caseSensitive: false,
  );

  /// Evaluates an inbound user query against the 3 deterministic guardrail filters
  static GuardrailEvaluation evaluate(String prompt) {
    final cleanPrompt = prompt.trim().toLowerCase();

    // Red-List Filter 1: Coding, Software Development & Tech Support
    if (_codingPattern.hasMatch(cleanPrompt)) {
      return GuardrailEvaluation.blocked(
        GuardrailStatus.blockedCoding,
        refusalCoding,
      );
    }

    // Red-List Filter 2: Specific Financial, Stock, Crypto, or Investment Advice
    if (_financialPattern.hasMatch(cleanPrompt)) {
      return GuardrailEvaluation.blocked(
        GuardrailStatus.blockedFinancialAdvice,
        refusalFinancial,
      );
    }

    // Red-List Filter 3: Snooping on Someone Else's Private Life
    if (_surveillancePattern.hasMatch(cleanPrompt)) {
      return GuardrailEvaluation.blocked(
        GuardrailStatus.blockedSurveillance,
        refusalSurveillance,
      );
    }

    // Green-List Allowed: Natal, transit, synastry, career timing, spiritual practice
    return GuardrailEvaluation.allowed("VedicAstrologyAndLifeGuidance");
  }
}
