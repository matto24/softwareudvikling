#include <iostream>
#include "database.h"
#include "client.cpp"

int main()
{
    
    Database db;
    db.connectionInit();

    Client cl;

    cl.printTasks();

    db.~Database();
    return 0;
}