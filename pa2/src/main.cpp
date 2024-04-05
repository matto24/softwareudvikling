#include <iostream>

#include "database.h"
#include "client.h"
#include "robot.h"

int main()
{

    Database db;
    db.connectionInit();

    Client cl(&db);
    Robot rb(&db, "Robot");
    std::cout << "Robot created\n";
    std::cout << "----------------------------------------\n";
    std::cout << "Robots:\n";
    cl.printRobots();
    std::cout << "----------------------------------------\n";
    cl.addTask();
    std::cout << "----------------------------------------\n";
    rb.completeTask();
    std::cout << "----------------------------------------\n";
    std::cout << "Tasks:\n";
    cl.printTasks();
    std::cout << "----------------------------------------\n";

    return 0;
}