import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/shared/utils/session_provider.dart';



String? getAuthHeaderFromRef(Ref ref) {
  final sessionId = ref.read(sessionProvider);
  print("ffsjidungsouosubr dfgusbosufgb uabfoudbngufh");
  if (sessionId == null) return null;
  print('Basic ${base64.encode(utf8.encode('$sessionId:placeholder'))}');
  return 'Basic ${base64.encode(utf8.encode('$sessionId:placeholder'))}';
}