#include "robot.h"
#include <iostream>


Robot::Robot(Database *db) : _db(*db) {}

void Robot::completeTask() {

  _db.removeTask();

}
