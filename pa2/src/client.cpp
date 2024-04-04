#include "client.h"
#include "database.h"
#include <iostream>
#include <vector>

Client::Client(Database *db) : _db(*db) {}

void Client::printTasks()
{
    std::vector<std::string> result;
    sql::ResultSet* tasks = _db.getInfo("SELECT name FROM task");

        while(tasks->next())
        {
            result.push_back(tasks->getString("name"));
        }
    int taskSize = result.size();

    for(int i=0; i<taskSize; i++) {
        std::cout << result[i] << std::endl;
    }
}