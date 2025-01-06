import 'dart:convert'; // Import for JSON encoding/decoding.
import 'package:http/http.dart' as http; // Import for making HTTP requests.
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import for managing environment variables.

class ChatService {
  // API key for OpenAI, loaded from environment variables.
  final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  // Function to get a chatbot response based on the user's input.
  Future<String> getChatbotResponse(String userInput) async {
    // API endpoint for OpenAI's completion model.
    final url = Uri.parse('https://api.openai.com/v1/completions');
    
    // Headers required for the HTTP request.
    final headers = {
      'Content-Type': 'application/json', // Specify the content type.
      'Authorization': 'Bearer $apiKey', // Bearer token for authorization.
    };

    // Request body with model details and user input.
    final body = jsonEncode({
      'model': 'text-davinci-003', // The GPT-3 model to use.
      'prompt': userInput, // The user's input to the model.
      'max_tokens': 150, // The maximum number of tokens to generate.
      'temperature': 0.7, // Controls the randomness of the response.
    });

    // Send a POST request to the OpenAI API.
    final response = await http.post(url, headers: headers, body: body);

    // Check if the response is successful (status code 200).
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Parse the response body.
      return data['choices'][0]['text'].trim(); // Extract and return the chatbot's response.
    } else {
      // Throw an exception if the request fails.
      throw Exception('Failed to load response');
    }
  }
}

