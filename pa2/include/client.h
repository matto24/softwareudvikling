#pragma once
#include <iostream>
#include "database.h"

class Client {

private:
Database _db;

public:
Client(Database *db);
void printTasks();
void addTask();
void printRobots();
};