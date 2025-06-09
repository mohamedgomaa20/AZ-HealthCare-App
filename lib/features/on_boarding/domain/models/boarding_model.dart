class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

final List<BoardingModel> boardingItems = [
  BoardingModel(
    image: "assets/images/onboard_1.png",
    title: "Welcome to AZ Healthcare",
    body:
    "Your personal AI-powered healthcare companion, ready to assist you anytime, anywhere.",
  ),
  BoardingModel(
    image: "assets/images/onboard_2.jpg",
    title: "AI-Powered Diagnosis",
    body:
    "Get instant medical insights and preliminary diagnoses using advanced AI technology.",
  ),
  BoardingModel(
    image: "assets/images/onboard_3.png",
    title: "24/7 Medical Support",
    body:
    "Access medical advice and support around the clock, whenever you need it.",
  ),
  BoardingModel(
    image: "assets/images/onboard_4.jpg",
    title: "Your Health Journey",
    body:
    "Track your health progress and get personalized recommendations for a healthier life.",
  ),
];
