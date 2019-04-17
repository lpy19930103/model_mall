import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class BottomCountEvent {
  int count;

  BottomCountEvent(this.count);
}
