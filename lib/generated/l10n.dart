// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `- -`
  String get base_placeholder_two {
    return Intl.message(
      '- -',
      name: 'base_placeholder_two',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get base_btn_cancel {
    return Intl.message(
      'Cancel',
      name: 'base_btn_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get base_btn_confirm {
    return Intl.message(
      'Confirm',
      name: 'base_btn_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get base_btn_complete {
    return Intl.message(
      'Finish',
      name: 'base_btn_complete',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get base_monday {
    return Intl.message(
      'Monday',
      name: 'base_monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get base_tuesday {
    return Intl.message(
      'Tuesday',
      name: 'base_tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get base_wednesday {
    return Intl.message(
      'Wednesday',
      name: 'base_wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get base_thursday {
    return Intl.message(
      'Thursday',
      name: 'base_thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get base_friday {
    return Intl.message(
      'Friday',
      name: 'base_friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get base_saturday {
    return Intl.message(
      'Saturday',
      name: 'base_saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get base_sunday {
    return Intl.message(
      'Sunday',
      name: 'base_sunday',
      desc: '',
      args: [],
    );
  }

  /// `Get verification code`
  String get base_get_check_code {
    return Intl.message(
      'Get verification code',
      name: 'base_get_check_code',
      desc: '',
      args: [],
    );
  }

  /// `Has been sent`
  String get base_already_send_msg {
    return Intl.message(
      'Has been sent',
      name: 'base_already_send_msg',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
