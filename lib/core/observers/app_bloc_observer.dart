import 'package:demo_app/core/mixins/bloc_debug_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

import '../extensions/app_extension/app_extension.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver();

  final Talker _talker = debugTalker;

  final TalkerBlocLoggerSettings settings = const TalkerBlocLoggerSettings(
    printEventFullData: true,
    printStateFullData: false,
  );

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (!settings.enabled || !settings.printEvents) {
      return;
    }
    final accepted = settings.eventFilter?.call(bloc, event) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
      _BlocEventLog(
        bloc: bloc,
        event: event,
        settings: settings,
      ),
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (!settings.enabled || !settings.printTransitions) {
      return;
    }
    final accepted = settings.transitionFilter?.call(bloc, transition) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
      _BlocStateLog(
        bloc: bloc,
        transition: transition,
        settings: settings,
      ),
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (!settings.enabled || !settings.printChanges) {
      return;
    }
    _talker.logCustom(
      _BlocChangeLog(
        bloc: bloc,
        change: change,
        settings: settings,
      ),
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _talker.error('${bloc.runtimeType}', error, stackTrace);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _talker.logCustom(
      _BlocCreateLog(
        bloc: bloc,
      ),
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _talker.logCustom(
      _BlocCloseLog(
        bloc: bloc,
      ),
    );
  }
}

class _BlocEventLog extends TalkerLog {
  _BlocEventLog({
    required this.bloc,
    required this.event,
    required this.settings,
  }) : super(
          settings.printEventFullData
              ? '${bloc.runtimeType} receive event:\n$event'
              : '${bloc.runtimeType} receive event: ${event.runtimeType}',
        );

  final Bloc bloc;
  final Object? event;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(51);

  @override
  String get title => 'bloc-event';

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage(timeFormat: timeFormat);
  }

  String _createMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    return sb.toString();
  }
}

class _BlocStateLog extends TalkerLog {
  _BlocStateLog({
    required this.bloc,
    required this.transition,
    required this.settings,
  }) : super('${bloc.runtimeType} with event ${transition.event.runtimeType}');

  final Bloc bloc;
  final Transition transition;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String get title => 'bloc-transition';

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage(timeFormat: timeFormat);
  }

  String _createMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write(
      '\n${'CURRENT state: ${settings.printStateFullData ? '\n${transition.currentState}' : transition.currentState.runtimeType}'}',
    );
    sb.write(
      '\n${'NEXT state: ${settings.printStateFullData ? '\n${transition.nextState}' : transition.nextState.runtimeType}'}',
    );
    return sb.toString();
  }
}

class _BlocChangeLog extends TalkerLog {
  _BlocChangeLog({
    required this.bloc,
    required this.change,
    required this.settings,
  }) : super('${bloc.runtimeType} changed');

  final BlocBase bloc;
  final Change change;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String get title => 'bloc-transition';

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage(timeFormat: timeFormat);
  }

  String _createMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write(
      '\n${'CURRENT state: ${settings.printStateFullData ? '\n${change.currentState}' : change.currentState.runtimeType}'}',
    );
    sb.write(
      '\n${'NEXT state: ${settings.printStateFullData ? '\n${change.nextState}' : change.nextState.runtimeType}'}',
    );
    return sb.toString();
  }
}

class _BlocCreateLog extends TalkerLog {
  _BlocCreateLog({
    required this.bloc,
  }) : super(
          '${bloc.runtimeType} created',
        );

  final BlocBase bloc;

  @override
  AnsiPen get pen => AnsiPen()..xterm(11);

  @override
  String get title => 'bloc-create';

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage(timeFormat: timeFormat);
  }

  String _createMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));

    if (bloc is BlocDebugMixin) {
      sb.write('\n${(bloc as BlocDebugMixin).toDebug()} created');
    } else {
      sb.write('\n$message');
    }

    return sb.toString();
  }
}

class _BlocCloseLog extends TalkerLog {
  _BlocCloseLog({
    required this.bloc,
  }) : super('${bloc.runtimeType} closed');

  final BlocBase bloc;

  @override
  AnsiPen get pen => AnsiPen()..xterm(9);

  @override
  String get title => 'bloc-close';

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage(timeFormat: timeFormat);
  }

  String _createMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));

    if (bloc is BlocDebugMixin) {
      sb.write('\n${(bloc as BlocDebugMixin).toDebug()} closed');
    } else {
      sb.write('\n$message');
    }

    return sb.toString();
  }
}
