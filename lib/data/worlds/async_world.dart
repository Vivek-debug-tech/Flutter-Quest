import '../../models/challenge_models.dart' as challenge_model;
import '../../models/world_model.dart';
import 'world_builders.dart';

final World asyncWorld = buildCurriculumWorld(
  id: 'world_8',
  title: 'Async & APIs',
  description: 'Work with Futures, remote data, and async error handling.',
  icon: 'A',
  requiredStars: 2,
  isLocked: true,
  levels: [
    buildCurriculumLevel(
      id: 'w8-l1',
      worldId: 'world_8',
      levelNumber: 1,
      title: 'Async/Await',
      concept: 'async and await',
      lessonText:
          'The async and await keywords make asynchronous code easier to read by letting it look more like normal step-by-step code.',
      guidedText:
          'Mark the function with async, then use await before the Future you want to wait for.',
      challengePrompt: 'Create an async function that awaits fetchData().',
      expectedCode:
          "Future<void> loadData() async {\n  await fetchData();\n}",
      validationRules: ['async', 'await', 'fetchData'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which keyword waits for a Future to complete?',
          options: ['async', 'await', 'future', 'then'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create an async function that awaits fetchData().',
          validationRules: ['async', 'await', 'fetchData'],
          codeSnippet:
              "Future<void> loadData() async {\n  await fetchData();\n}",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the function so it properly waits for fetchData().',
          brokenCode:
              "Future<void> loadData() async {\n  fetchData();\n}",
          fixRules: ['async', 'await', 'fetchData'],
          codeSnippet:
              "Future<void> loadData() async {\n  await fetchData();\n}",
        ),
      ],
      keyPoints: [
        'async marks a function as asynchronous.',
        'await pauses until the Future completes.',
        'This style is easier to read than chained callbacks.',
      ],
      hints: [
        'Use both async and await.',
        'Await the call to fetchData().',
        "Future<void> loadData() async {\n  await fetchData();\n}",
      ],
    ),
    buildCurriculumLevel(
      id: 'w8-l2',
      worldId: 'world_8',
      levelNumber: 2,
      title: 'FutureBuilder',
      concept: 'FutureBuilder widget',
      lessonText:
          'FutureBuilder rebuilds the UI when a Future changes state, making it easier to show loading, success, and error states in asynchronous interfaces.',
      guidedText:
          'FutureBuilder usually needs a future: and a builder: function that reads the AsyncSnapshot.',
      challengePrompt:
          'Use FutureBuilder with a future and builder callback.',
      expectedCode:
          "FutureBuilder(\n  future: fetchData(),\n  builder: (context, snapshot) {\n    return Text('Loaded');\n  },\n)",
      validationRules: ['FutureBuilder(', 'future:', 'builder:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget rebuilds from the state of a Future?',
          options: ['StreamBuilder', 'Builder', 'FutureBuilder', 'AsyncWidget'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Use FutureBuilder with a future and builder callback.',
          validationRules: ['FutureBuilder(', 'future:', 'builder:'],
          codeSnippet:
              "FutureBuilder(\n  future: fetchData(),\n  builder: (context, snapshot) {\n    return Text('Loaded');\n  },\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What text is returned in this FutureBuilder builder?',
          codeSnippet:
              "FutureBuilder(\n  future: fetchData(),\n  builder: (context, snapshot) {\n    return Text('Loaded');\n  },\n)",
          expectedOutput: 'Loaded',
        ),
      ],
      keyPoints: [
        'FutureBuilder reacts to async completion.',
        'future: provides the async task.',
        'builder: returns UI for the current snapshot state.',
      ],
      hints: [
        'Use the widget that builds from a Future.',
        'Add both future: and builder:.',
        "FutureBuilder(\n  future: fetchData(),\n  builder: (context, snapshot) {\n    return Text('Loaded');\n  },\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w8-l3',
      worldId: 'world_8',
      levelNumber: 3,
      title: 'HTTP Request',
      concept: 'HTTP GET request',
      lessonText:
          'HTTP requests fetch data from servers and APIs. In Flutter, this often starts with a simple GET request using the http package.',
      guidedText:
          'Use http.get and wrap the URL in Uri.parse so Flutter treats it as a valid Uri object.',
      challengePrompt:
          'Write an HTTP GET request for https://example.com.',
      expectedCode:
          "await http.get(Uri.parse('https://example.com'))",
      validationRules: ['http.get(', 'Uri.parse(', 'https://example.com'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which function converts a URL string to a Uri object?',
          options: ['Uri.get', 'Uri.parse', 'http.parse', 'Route.parse'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Write an HTTP GET request for https://example.com.',
          validationRules: ['http.get(', 'Uri.parse(', 'https://example.com'],
          codeSnippet:
              "await http.get(Uri.parse('https://example.com'))",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the HTTP request so the URL is wrapped correctly.',
          brokenCode:
              "await http.get('https://example.com')",
          fixRules: ['http.get(', 'Uri.parse(', 'https://example.com'],
          codeSnippet:
              "await http.get(Uri.parse('https://example.com'))",
        ),
      ],
      keyPoints: [
        'http.get performs a GET request.',
        'Uri.parse converts the string URL to a Uri.',
        'await waits for the server response.',
      ],
      hints: [
        'Use http.get for the request.',
        'Wrap the URL with Uri.parse(...).',
        "await http.get(Uri.parse('https://example.com'))",
      ],
    ),
    buildCurriculumLevel(
      id: 'w8-l4',
      worldId: 'world_8',
      levelNumber: 4,
      title: 'JSON Parsing',
      concept: 'jsonDecode',
      lessonText:
          'JSON parsing converts response text into Dart maps and lists that your app can read and use.',
      guidedText:
          'Use jsonDecode when you have a JSON string and need to convert it into structured Dart data.',
      challengePrompt: 'Decode a JSON string using jsonDecode.',
      expectedCode: 'final data = jsonDecode(responseBody)',
      validationRules: ['jsonDecode(', 'responseBody'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which function converts JSON text into Dart data?',
          options: ['decodeJson', 'parseJson', 'jsonDecode', 'dataDecode'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Decode a JSON string using jsonDecode.',
          validationRules: ['jsonDecode(', 'responseBody'],
          codeSnippet: 'final data = jsonDecode(responseBody)',
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'Which variable is passed into jsonDecode here?',
          codeSnippet: 'final data = jsonDecode(responseBody)',
          expectedOutput: 'responseBody',
        ),
      ],
      keyPoints: [
        'jsonDecode parses a JSON string.',
        'The result is usually a Map or List.',
        'Parsed data can then be accessed in Dart.',
      ],
      hints: [
        'Use the JSON decode function.',
        'Pass responseBody into jsonDecode(...).',
        'final data = jsonDecode(responseBody)',
      ],
    ),
    buildCurriculumLevel(
      id: 'w8-l5',
      worldId: 'world_8',
      levelNumber: 5,
      title: 'Error Handling',
      concept: 'try/catch in async code',
      lessonText:
          'Async code should handle exceptions so the app can recover gracefully when network requests fail or data parsing breaks.',
      guidedText:
          'Place the awaited work in a try block and handle failures in a catch block.',
      challengePrompt: 'Handle an async error using try and catch.',
      expectedCode:
          "try {\n  await fetchData();\n} catch (error) {\n  print(error);\n}",
      validationRules: ['try', 'catch', 'await'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which block handles exceptions thrown inside try?',
          options: ['finally', 'guard', 'catch', 'throw'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Handle an async error using try and catch.',
          validationRules: ['try', 'catch', 'await'],
          codeSnippet:
              "try {\n  await fetchData();\n} catch (error) {\n  print(error);\n}",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the error handling so failures are caught correctly.',
          brokenCode:
              "try {\n  await fetchData();\n} finally (error) {\n  print(error);\n}",
          fixRules: ['try', 'catch', 'await'],
          codeSnippet:
              "try {\n  await fetchData();\n} catch (error) {\n  print(error);\n}",
        ),
      ],
      keyPoints: [
        'try runs code that might fail.',
        'catch handles the exception.',
        'Error handling is critical for async and network code.',
      ],
      hints: [
        'Use both try and catch.',
        'Place await fetchData() inside the try block.',
        "try {\n  await fetchData();\n} catch (error) {\n  print(error);\n}",
      ],
    ),
  ],
);
