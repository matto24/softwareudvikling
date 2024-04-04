#include "client.h"
#include "database.h"
#include <iostream>
#include <vector>

void Client::printTasks()
{
    Database db;
    std::vector<std::string> tasks = db.getInfo("SELECT name FROM task");
    for(int i=0; i<tasks.size(); i++) {
        std::cout << tasks[i] << std::endl;
    }
}