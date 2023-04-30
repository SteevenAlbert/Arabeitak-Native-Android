import 'package:authorization_header/authorization_header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Map<String, Map<String, dynamic>>> instructions = [
  {
    "2016 toyota corolla how to find vehicle identification number (VIN)": {
      "id": "cmpl-6oFQM0m444SbfSB5r8npYhmkqbUAT",
      "object": "text_completion",
      "created": 1677433710,
      "model": "text-davinci-003",
      "choices": [
        {
          "text":
              "\n\nThe Toyota Corolla's VIN can be found on the driver’s side of the dashboard on the windshield, on your vehicle title, or on your vehicle registration card.",
          "index": 0,
          "logprobs": null,
          "finish_reason": "stop"
        }
      ],
      "usage": {
        "prompt_tokens": 14,
        "completion_tokens": 38,
        "total_tokens": 52
      }
    }
  },
  {
    "2016 toyota corolla how to open car hood": {
      "id": "cmpl-6oFdb6JCWv3SLI1PhnujNtQkuLfpg",
      "object": "text_completion",
      "created": 1677434531,
      "model": "text-davinci-003",
      "choices": [
        {
          "text":
              "\n\n1. Locate the hood release lever inside the vehicle. The release lever is usually located under the dashboard on the driver’s side.\n\n2. Pull the release lever. This will unlock the hood and allow you to open it.\n\n3. Locate the hood latch under the hood. The hood latch is usually located near the center of the vehicle's front grille.\n\n4. Push down on the hood latch to release it.\n\n5. Lift up on the hood to open it.",
          "index": 0,
          "logprobs": null,
          "finish_reason": "stop"
        }
      ],
      "usage": {
        "prompt_tokens": 10,
        "completion_tokens": 109,
        "total_tokens": 119
      }
    }
  },
  {
    "2016 toyota corolla how to Jumpstart a Dead Battery": {
      "id": "cmpl-6oFhHa6pBE7u4VBLEfTLkWLUZj9TQ",
      "object": "text_completion",
      "created": 1677434759,
      "model": "text-davinci-003",
      "choices": [
        {
          "text":
              "\n\n1. Prepare your car. Park the dead car (with the problem battery) close to the car with a working battery, ensuring that the vehicles don't touch. Turn both cars off, remove all accessories like radios, air conditioning and lights, and put both of the vehicles into park or neutral.\n\n2. Connect the jumper cables. Attach one end of the positive (red) cable to the dead battery's positive (also marked +) terminal. Attach the other end of the positive cable to the good battery's positive terminal. Next, attach one end of the negative (black) cable to the good battery's negative terminal. Finally, attach the other end of the negative cable to a clean, grounded metal surface on the dead car that is not near the battery (not directly on the negative terminal).\n\n3. Start the vehicles. Start the car with the working battery first, and allow it to run for a few minutes. Then start the car with the dead battery.\n\n4. Disconnect the cables. Once the car with the dead battery is running, disconnect the cables in the reverse order. Disconnect the negative (black) cable from the grounded surface first. Then disconnect the negative cable from the good battery. Disconnect the positive (red) cable from the good battery. Finally, disconnect the positive cable from the dead battery.",
          "index": 0,
          "logprobs": null,
          "finish_reason": null
        }
      ],
      "usage": {
        "prompt_tokens": 12,
        "completion_tokens": 278,
        "total_tokens": 290
      }
    }
  },
  {
    "2016 toyota corolla how to Check your coolant": {
      "id": "cmpl-6oKIuHNSiO5qP54r6GlQo5VkBu6NU",
      "object": "text_completion",
      "created": 1677452468,
      "model": "text-davinci-003",
      "choices": [
        {
          "text":
              "\n\nTo check your coolant in a Toyota Corolla (2016 model):\n\n1. Start your engine and let it idle for about two minutes to allow the engine to warm up.\n\n2. Make sure the engine is turned off and the car is parked in a safe place.\n\n3. Open the hood of the car and locate the coolant reservoir.\n\n4. Check the level of the coolant in the reservoir. It should be between the \"Low\" and \"Full\" markings printed on the side of the reservoir.\n\n5. If the coolant level is low, you can add coolant using a funnel and a hose. Be sure not to overfill the reservoir.\n\n6. Check the colour of the coolant; it should have a light green colour. If it is brown or black in colour, then you may need to have the cooling system flushed and new coolant added.\n\n7. Close the hood and replace the coolant cap.",
          "index": 0,
          "logprobs": null,
          "finish_reason": null
        }
      ],
      "usage": {
        "prompt_tokens": 11,
        "completion_tokens": 205,
        "total_tokens": 216
      }
    }
  },
  {
    "2016 toyota corolla how to Check your engine oil": {
      "id": "cmpl-6oKQIG56SmFl9OCkzJXXYlbB73N07",
      "object": "text_completion",
      "created": 1677452926,
      "model": "text-davinci-003",
      "choices": [
        {
          "text":
              "\n\n1. Park your Toyota Corolla on level ground and set the parking brake.\n2. Open the hood and locate the engine oil dipstick. It is on the passenger side of the engine and is usually yellow in color. \n3. Pull out the dipstick and wipe off the oil on the end of it with a clean rag.\n4. Reinsert the dipstick into the engine and pull it out again.\n5. Check the level of oil on the end of the dipstick. The oil should be between the two marks -- not below the lower mark or above the upper one.\n6. Add oil if necessary and make sure the oil type and viscosity matches the owner's manual specifications. \n7. Close the hood when you are finished.",
          "index": 0,
          "logprobs": null,
          "finish_reason": "stop"
        }
      ],
      "usage": {
        "prompt_tokens": 11,
        "completion_tokens": 161,
        "total_tokens": 172
      }
    }
  },
  //TODO: rest of instructions from postman
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
  }
];

//TODO: new openAI account
final authHeader = Auth.of()
    .bearer(token: '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');

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
