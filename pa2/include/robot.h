#pragma once
#include "database.h"

class Robot
{
private:
    Database _db;
public:
    Robot(Database *db);

    void completeTask();
};