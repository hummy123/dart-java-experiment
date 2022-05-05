import 'dart:io';
import 'dart:isolate';

int requestsHandled = 0;
List<int> durationList = [];

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

// spawn an isolate
Future<void> createIsolate() async {
  var rp = ReceivePort();
  rp.listen(
    (message) {
      requestsHandled += 1;
      print(requestsHandled);
      durationList.add(message as int);
      var totalTime = durationList.reduce(
        (value, element) => value + element,
      );
      print("Time taken for $requestsHandled requests:");
      var dur = Duration(microseconds: totalTime);
      print(_printDuration(dur));
      //just listening for one message, so close after
      rp.close();
    },
  );
  await Isolate.spawn(computeInIsolate, rp.sendPort);
}

void computeInIsolate(SendPort sendPort) async {
  const int maxNum = 2147483647;
  int counter = 0;

  var start = DateTime.now();
  while (counter < maxNum) {
    counter += 1;
  }
  var end = DateTime.now();

  var difference = end.difference(start);
  Isolate.exit(sendPort, difference.inMicroseconds);
}

void main(List<String> args) async {
  while (true) {
    await createIsolate();
  }
}
