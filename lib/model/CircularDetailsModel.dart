class CircularDetailModel {
  String circularNo;
  String type;
  String subject;
  String url;

  CircularDetailModel(
      {required this.circularNo,
      required this.type,
      required this.subject,
      required this.url});

  static List<CircularDetailModel> dummyData() {
    return [
      CircularDetailModel(
          circularNo: "32025",
          type: "Staff Circulars",
          subject: "D I S H A - Vol2 Issue 6 ",
          url: "http://xyz.com"),
      CircularDetailModel(
          circularNo: "03212-2022",
          type: "Instruction Circulars",
          subject:
              "Revision of Interest Rates on Domestic/NRO/\nNRE Rupee Term Deposits ",
          url: "http://xyz.com"),
      CircularDetailModel(
          circularNo: "03195-2022",
          type: "Instruction Circulars",
          subject: "Corporate Communication Policy 2022-2023",
          url: "http://xyz.com"),
      CircularDetailModel(
          circularNo: "003155-2022",
          type: "Instruction Circulars",
          subject:
              "Management of MSME Portfolio - MSME Festive\nBonanza Campaign - Last date for regular\nsanction of leads mobilized",
          url: "http://xyz.com"),
      CircularDetailModel(
          circularNo: "07666",
          type: "Staff Circulars",
          subject: "Stass Pensioners - Investment Decalration for FY\n2022-23",
          url: "http://xyz.com"),
      CircularDetailModel(
          circularNo: "07665",
          type: "Staff Circulars",
          subject:
              "Result for Selection of Director of Rural Self Employment Training Institute (RSETIs)(For the \n vacancies to be filled up to March 2023)",
          url: "http://xyz.com"),
      CircularDetailModel(
          circularNo: "03214-2022",
          type: "Instruction Circulars",
          subject:
              "Monitoring of activities of BC by Branches & \nRegional Offices",
          url: "http://xyz.com")
    ];
  }
}
