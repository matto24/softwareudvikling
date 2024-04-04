#include <iostream>
#include "database.h"
#include "client.h"

int main(int argc, char const *argv[])
{
    
    Database db;
    db.connectionInit();

    Client cl(&db);
    cl.addTask();
    cl.printTasks();

    return 0;
}