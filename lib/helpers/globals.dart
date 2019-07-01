import 'dart:async';
import 'package:simplefire/helpers/global_event.dart';

final StreamController<GlobalEvent> globalEventController = StreamController.broadcast();