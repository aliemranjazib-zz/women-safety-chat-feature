class Doctor {
  final String? name;
  final String? specialist;
  final String? rating;
  final String? reviews;
  final String? academy;
  final String? image;
  final String? description;

  Doctor(
      {this.name,
      this.specialist,
      this.rating,
      this.reviews,
      this.academy,
      this.image,
      this.description});
}

class Consultation {
  final String? title;
  final String? subtitle;
  final String? price;
  Consultation({this.title, this.subtitle, this.price});
}

List<Consultation> consultation = [
  Consultation(
      title: "cardio Issues?",
      price: "100",
      subtitle: "for cardio patient here can easily contact with doctor."),
  Consultation(
      title: "Dental trouble?",
      price: "80",
      subtitle: "for dental patient here can easily contact with doctor."),
  Consultation(
      title: "Heart Issues?",
      price: "250",
      subtitle: "for heart patient here can easily contact with doctor."),
  Consultation(
      title: "Eyes Issues?",
      price: "500",
      subtitle: "for Eyes patient here can easily contact with doctor."),
  Consultation(
      title: "Therapist Issues?",
      price: "50",
      subtitle: "for theropy patient here can easily contact with doctor."),
];
List<Doctor> doctorlist = [
  Doctor(
    name: "Dr Areeb",
    rating: "4.5",
    reviews: "27",
    specialist: "cardiologist",
    academy: "Sahiwal Medical College",
    image: "images/doc1.jpg",
    description:
        "Cardiologists are doctors who specialize in diagnosing and treating diseases or conditions of the heart"
        "and blood vessels—the cardiovascular system.",
  ),
  Doctor(
    name: "Dr Saim",
    rating: "4.9",
    reviews: "56",
    specialist: "Heart Surgeon",
    academy: "Sahiwal Medical College",
    image: "images/doc2.jpg",
    description:
        "A cardiac surgeon is a medical doctor who has advanced education and training in performing surgery on the"
        "heart and the major blood vessels around it.",
  ),
  Doctor(
      name: "Dr Hassan",
      rating: "3.5",
      reviews: "56",
      specialist: "Eyes",
      academy: "Sahiwal Medical College",
      image: "images/doc3.jpg",
      description:
          "An ophthalmologist — Eye M.D. — is a medical or osteopathic doctor who specializes in eye and vision care."
          "Ophthalmologists differ from optometrists and opticians in their levels of training and in what they can diagnose and treat."),
  Doctor(
      name: "Dr Imran",
      rating: "5.5",
      reviews: "99",
      specialist: "Therapist",
      academy: "Sahiwal Medical College",
      image: "images/doc1.jpg",
      description:
          "Therapists, or psychotherapists, are licensed mental health professionals who specialize in helping clients"
          "develop better cognitive and emotional skills, reduce symptoms of mental illness, and cope with various life challenges"
          "to improve their lives."),
  Doctor(
      name: "Dr Mnan",
      rating: "5.5",
      reviews: "98",
      specialist: "Dental",
      academy: "Sahiwal Medical College",
      image: "images/doc2.jpg",
      description:
          "Dentists diagnose and treat dental issues and help patients develop better oral hygiene regimens."
          "They clean teeth, correct bite issues, perform surgeries and extractions and perform other duties to ensure that"
          "the teeth and mouth are healthy."),
];
