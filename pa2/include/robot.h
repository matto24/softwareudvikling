#pragma once
#include "database.h"

class Robot
{
private:
    Database _db;
    std::string _name;
public:
    Robot(Database *db, std::string name);
    ~Robot();
    void completeTask(std::string taskName);
};