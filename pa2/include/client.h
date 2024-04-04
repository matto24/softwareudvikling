#pragma once

#include "database.h"

class Client {

private:
Database _db;

public:
Client(Database *db);
void printTasks();

};