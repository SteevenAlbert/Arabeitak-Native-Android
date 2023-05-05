// ignore_for_file: public_member_api_docs, sort_constructors_first
class Instruction {
  String instnum;
  String text;
  int? trigger;
  List<String>? guidingtext;
  Instruction(
      {required this.instnum,
      required this.text,
      this.guidingtext,
      this.trigger});
  static List<Instruction> instlist = [
    Instruction(
        instnum: '1', text: "Locate the Radiator, as pointed by the arrow."),
    Instruction(
        instnum: '2',
        text: "Remove the oil filter cap by turning it counterclockwise",
        guidingtext: [
          "Make sure the engine is has cooled down.",
          "Use a towel to twist off the cap."
        ],
        trigger: 2),
    Instruction(
        instnum: '3',
        text: "Add Water to the radiator.",
        guidingtext: ["Avoid filling the radiator with cool water."],
        trigger: 2),
    Instruction(instnum: '4', text: "Replace the cap."),
  ];
}
