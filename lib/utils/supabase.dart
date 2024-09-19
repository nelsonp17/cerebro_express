import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<PostgrestList> supabaseInsert(String table, row) async {
  final response = await supabase.from(table).insert(row);

  return response;
}

Future<PostgrestList> supabaseSelect(String table) async {
  final response = await supabase.from(table).select();

  return response;
}

Future<PostgrestList> supabaseUpdate(String table, row) async {
  final response = await supabase.from(table).insert(row);

  return response;
}

Future<PostgrestList> getGames() async {
  final response = await supabase.from('games').select();

  return response;
}
