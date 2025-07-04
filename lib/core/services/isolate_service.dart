import 'dart:async';
import 'dart:isolate';

class IsolateService {
  IsolateService._();

  static Future<T> run<T, S>(FutureOr<T> Function(S message) handler, S message) async {
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn<_IsolateConfig<T, S>>(
      _isolateEntry,
      _IsolateConfig<T, S>(
        handler: handler,
        message: message,
        sendPort: receivePort.sendPort,
      ),
    );

    final T result = await receivePort.first as T;
    receivePort.close();
    return result;
  }

  static void _isolateEntry<T, S>(_IsolateConfig<T, S> config) async {
    final result = await config.handler(config.message);
    config.sendPort.send(result);
  }
}

class _IsolateConfig<T, S> {
  final FutureOr<T> Function(S) handler;
  final S message;
  final SendPort sendPort;

  _IsolateConfig({
    required this.handler,
    required this.message,
    required this.sendPort,
  });
}
