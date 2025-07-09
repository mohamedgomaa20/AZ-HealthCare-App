import '../../../../core/utils/app_images.dart';

class BoardingModel {
  final String image;
  final String title;
  final String description;

  BoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<BoardingModel> boardingItems = [
  BoardingModel(
    image: AppImages.onboardImage1,
    title: "Welcome to A2Z Healthcare",
    description:
        "Your personal AI-powered healthcare companion, ready to assist you anytime, anywhere made by Azhar Group.",
  ),
  BoardingModel(
    image: AppImages.onboardImage2,
    title: "Features",
    description:
        "Step Tracker, Calories Tracking, Water Intake Tracker, Medication Reminder, Medication History, Blood Pressure Prediction (AI-powered), Accident Alert (sends location and alert to emergency contacts).",
  ),
  BoardingModel(
    image: AppImages.onboardImage3,
    title: "VIP Features",
    description:
        "Ability to order medicine directly via the app with faster delivery and exclusive service. Request doctor consultations remotely through the app.",
  ),
];
