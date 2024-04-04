#include <iostream>


#include "database.h"
#include "client.h"
#include "robot.h"

int main()
{
    
    Database db;
    db.connectionInit();

    Client cl(&db);
    Robot rb(&db);
    
    cl.addTask();
    std::cout << "----------------------------------------\n";
    rb.completeTask();
    cl.printTasks();

    return 0;
}