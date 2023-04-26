//public class RestAPI extends AsyncTask<Void, Void, Void> {
//
//    // Create URL
//    URL url = new URL("https://api.openai.com/v1/engines/text-davinci-003/completions")
//
//    // Create connection
//    connection = url.openConnection() as HttpURLConnection
//
//    // Set Request method
//    connection.requestMethod = "POST";
//
//    // // Create the prompt
//    // String prompt = "message=Hello";
//
//    // // Enable writing
//    // connection.setDoOutput(true);
//
//    // // Write the data
//    // connection.getOutputStream().write(prompt.getBytes());
//
//    connection.setRequestProperty("Content-Type",
//    "application/json");
//
//    // if (connection.getResponseCode() == 200) {
//    //     // Success
//    //     // Further processing here
//    // } else {
//    //     // Error handling code goes here
//    // }
//
//    InputStream responseBody = connection.getInputStream();
//
//    val reader = InputStreamReader(`in`)
//    var data = reader.read()
//
//    // InputStreamReader responseBodyReader =
//    //     new InputStreamReader(responseBody, "UTF-8");
//
//    // JsonReader jsonReader = new JsonReader(responseBodyReader);
//
//    // jsonReader.beginObject(); // Start processing the JSON object
//    // while (jsonReader.hasNext()) { // Loop through all keys
//    //     String key = jsonReader.nextName(); // Fetch the next key
//    //     if (key.equals("organization_url")) { // Check if desired key
//    //         // Fetch the value as a String
//    //         String value = jsonReader.nextString();
//
//    //         // Do something with the value
//    //         // ...
//
//    //         break; // Break out of the loop
//    //     } else {
//    //         jsonReader.skipValue(); // Skip values of other keys
//    //     }
//    // }
//
//    // jsonReader.close();
//
//    connection.disconnect();
//
//}