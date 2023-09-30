import 'package:logger/logger.dart';

import 'options.dart';

const defaultHttpFormatterOptions = HttpFormatterOptions();

final defaultLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: true,
    printTime: false,
    printEmojis: false,
  ),
);
