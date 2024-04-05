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

//Takes the first task from the list and removes it
void Robot::completeTask(std::string taskName) {
  _db.addTaskToRobot(_name, taskName);
  _db.removeTask();
}
