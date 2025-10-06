import 'package:expense_tracker/models/Participants/participants_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const PARTICIPENTS_DB_NAME = 'participents_db';

abstract class ParticipentsDbFunctions {
  Future<void> initParticipantBox();
  Future<void> addParticipant(ParticipantsModel obj);
  List<ParticipantsModel> getAllParticipants();
  ParticipantsModel? getParticipantsById(String id);
  List<ParticipantsModel> getParticipantsByEventId(String eventId);
  Future<void> updateParticipants(ParticipantsModel obj);
  Future<void> deleteParticipants(String id);
  Future<void> refreshUI();
}

class ParticipantDb extends ParticipentsDbFunctions {
  ParticipantDb._internal();
  static ParticipantDb instance = ParticipantDb._internal();
  factory ParticipantDb() {
    return instance;
  }

  ValueNotifier<List<ParticipantsModel>> participantsListNotifer =
      ValueNotifier([]);
  late final Box<ParticipantsModel> _participentsBox;

  @override
  Future<void> initParticipantBox() async {
    _participentsBox = await Hive.openBox<ParticipantsModel>(
      PARTICIPENTS_DB_NAME,
    );
  }

  @override
  Future<void> addParticipant(ParticipantsModel obj) async {
    await _participentsBox.put(obj.id, obj);
    await refreshUI();
  }

  @override
  List<ParticipantsModel> getAllParticipants() {
    return _participentsBox.values.toList();
  }

  @override
  ParticipantsModel? getParticipantsById(String id) {
    try {
      return _participentsBox.values.firstWhere((i)=>i.participantId==id);
    } catch (_) {
      return null;
    }
  }

  @override
  List<ParticipantsModel> getParticipantsByEventId(String eventId) {
    return _participentsBox.values.where((i) => i.eventId == eventId).toList();
  }

  @override
  Future<void> updateParticipants(ParticipantsModel obj) async {
    await _participentsBox.put(obj.id, obj);
    await refreshUI();
  }

  @override
  Future<void> deleteParticipants(String id) async {
    await _participentsBox.delete(id);
    await refreshUI();
  }

  @override
  Future<void> refreshUI() async {
    participantsListNotifer.value = getAllParticipants();
    participantsListNotifer.value = [...participantsListNotifer.value];
  }

  String getParticipantName(String? id) {
    if (id == null) return "Admin Entry";
    final participant = getParticipantsById(id);


    return participant != null
        ? participant.participantName
        : "Unknown Participant";
  }
}
