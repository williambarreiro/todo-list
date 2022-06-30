import 'package:todo_list/app/core/database/migrations/migration_v1.dart';

import 'migrations/migration.dart';
import 'migrations/migration_v2.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
        MigrationV2(),
      ];
  List<Migration> getUpgradeMigration(int oldVersion) {
    final migrations = <Migration>[];

    if (oldVersion == 1) {
      migrations.add(MigrationV2());
    }

    return migrations;
  }
}
