#include "robot.h"
#include <iostream>


Robot::Robot(Database *db, std::string name) {
  _db = *db;
  _db.addRobot(name);
  _name = name;
}

Robot::~Robot() {
  _db.removeRobot(_name);
}

void Robot::completeTask() {
  _db.removeTask();
}
