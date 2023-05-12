// import "package:arabeitak_flutter_ui/licenses/keys.dart";
import 'package:authorization_header/authorization_header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Map<String, Map<String, dynamic>>> instructions = [
  {
    "2016 toyota corolla how to change tyre":
        // """
        {
      "id": "cmpl-6oG6hxj5OvlPHcNllqaDK5ljSV54k",
      "object": "text_completion",
      "created": 1677436335,
      "model": "text-davinci-003",
      "choices": [
        {
          "text":
              "\n\n1.Park your Toyota Corolla on a level surface and set the parking brake.\n2.Apply wheel wedges to the rear tires to prevent the car from rolling away.\n3.Take your tire iron and loosen the wheel lug nuts by turning them counter-clockwise.\n4.Raise your car with a jack.\n5.Remove the wheel lug nuts and take off the wheel.\n6.Put the flat tire in a secure place away from passing traffic.\n7.Put on the spare tire and thread the wheel lug nuts by hand.\n8.Lower the car to the ground using the jack.\n9.Tighten the wheel lug nuts with a tire iron and make sure they are secured tightly.\n10.Lower the car from the jack and apply the wheel wedges to the rear tires.",
          "index": 0,
          "logprobs": null,
          "finish_reason": "stop"
        }
      ],
      "usage": {
        "prompt_tokens": 10,
        "completion_tokens": 172,
        "total_tokens": 182
      }
    }
    // """
  },
];

//TODO: new openAI account
// final authHeader = Auth.of().bearer(token: openAIBearerToken);

class GPT {
  // static Future<http.Response> getProcedure(
  static Map<String, dynamic> getProcedure(
      String carModel, String procedureName) {
    // return http.post(
    //   Uri.parse(
    //       'https://api.openai.com/v1/engines/text-davinci-003/completions'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json',
    //     authHeader.name: authHeader.value,
    //   },
    //   body: jsonEncode(<String, dynamic>{
    //     'prompt': '$carModel how to $procedureName',
    //     "max_tokens": 4000
    //   }),
    // );
    var index = instructions
        .indexWhere((c) => c.containsKey('$carModel how to $procedureName'));
    return Map.fromIterable(instructions
        .elementAt(index)
        .values
        .map((e) => e.toString().substring(1, e.toString().length - 1)));
  }

  static run(String carModel, String procedureName) async {
    // getProcedure(carModel, procedureName).then((value) {
    var value = getProcedure(carModel, procedureName);
    print(">>>>VALUE<<<<");
    print(value);

    // var response = value.body;
    var response = value;

    // var responseMap = Map.from(json.decode(response.toString()));
    var responseMap = response;

    //TODO: datatype issue
    var choices = responseMap['choices'];
    // print(choices);
    choices ??= responseMap['error'];
    // print(choices);
    choices = List.from(choices);
    print(">>>>CHOICES<<<<");
    print(choices);

    var text = choices[0]['text'];
    text ??= choices[0]['message'];

    var list = text.trim();
    list = list.replaceAll("\n\n", " \n").split('\n');
    // for (int i = 0; i < list.length; i++) {
    //   list[i] = list[i][0].isNumeric ? list[i].substring(2) : list[i];
    // }

    print(">>>>LIST<<<<");
    print(list);
    return list;
    // });
  }
}
