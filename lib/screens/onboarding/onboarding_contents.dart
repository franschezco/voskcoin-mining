class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Crypto Assets Secured",
    image: "assets/images/image2.png",
    desc: "Remember to keep track of your professional accomplishments.",
  ),
  OnboardingContents(
    title: "Cloud & ASIC Bitcoin Mining",
    image: "assets/images/image1.png",
    desc:
    "But understanding the contributions our colleagues make to our team.",
  ),
  OnboardingContents(
    title: "Fastest Payouts Systems",
    image: "assets/images/image3.png",
    desc:
    "Take control of notifications, collaborate live or on your own time.",
  ),
];