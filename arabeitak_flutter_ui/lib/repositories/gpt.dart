import "package:arabeitak_flutter_ui/licenses/keys.dart";
import 'package:authorization_header/authorization_header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Map<String, List<String>>> instructions = [];

final authHeader = Auth.of().bearer(token: openAIBearerToken);

class GPT {
  runPrompt(String prompt) async {
    return http.post(
      Uri.parse(
          'https://api.openai.com/v1/engines/text-davinci-003/completions'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        authHeader.name: authHeader.value,
      },
      body: jsonEncode(<String, dynamic>{'prompt': prompt, "max_tokens": 4000}),
    );
  }

  getProcedure(String carModel, String procedureName) async {
    String prompt = 'for a $carModel, how to $procedureName';
    //  String prompt =
    //       'on what pages in this $carModel user\'s manual https://drive.google.com/file/d/1lp7zDgOi_LR3Cq3O-ZHdLr0_2JDTl7kl/view?usp=sharing are intstructions on how to $procedureName';
    // String prompt =
    //     'using this user\'s manual https://drive.google.com/file/d/1lp7zDgOi_LR3Cq3O-ZHdLr0_2JDTl7kl/view?usp=sharing, find instructions on how to $procedureName for a $carModel';
    // print(">>>>PROMPT<<<<");
    // print(prompt);
    var index = instructions.indexWhere((c) => c.containsKey(prompt));
    print(">>>>INDEX<<<<");
    print(index);
    if (index != -1) {
      return instructions.elementAt(index).values;
    } else {
      runPrompt(prompt).then((value) {
        // print(">>>>VALUE<<<<");
        // print(value);

        var response = value.body;

        var responseMap = Map.from(json.decode(response.toString()));

        var choices = responseMap['choices'];
        choices ??= responseMap['error'];
        choices = List.from(choices);
        // print(">>>>CHOICES<<<<");
        // print(choices);

        var text = choices[0]['text'];
        text ??= choices[0]['message'];

        var list = text.trim();

        list = list.replaceAll("\n\n", " \n").split('\n');
        for (int i = 0; i < list.length; i++) {
          list[i] = double.tryParse(list[i][0]) != null
              ? list[i].substring(2)
              : list[i];
        }

        print(">>>>LIST<<<<");
        print(list);

        instructions.add({prompt: list});
        return list;
      });
    }
  }

  getResponse(String prompt) async {
    return runPrompt(prompt).then((value) {
      var response = value.body;

      var responseMap = Map.from(json.decode(response.toString()));

      var choices = responseMap['choices'];
      choices = List.from(choices);

      var text = choices[0]['text'];

      return text.trim();
    });
  }
}
