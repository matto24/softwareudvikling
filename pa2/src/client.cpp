#include "client.h"
#include "database.h"
#include <iostream>
#include <vector>
#include <string>

Client::Client(Database *db) : _db(*db) {}

void Client::printTasks()
{
    std::vector<std::string> result;
    sql::ResultSet *tasks = _db.getInfo("SELECT name FROM task");

    while (tasks->next())
    {
        result.push_back(tasks->getString("name"));
    }
    int taskSize = result.size();

    for (int i = 0; i < taskSize; i++)
    {
        std::cout << result[i] << std::endl;
    }
}

void Client::addTask()
{
    std::string taskName;
    std::cout << "Enter task name: ";
    std::getline(std::cin, taskName);
    std::cout << "task: (" << taskName << ") added to database" << std::endl;
    _db.addTask(taskName);
}

void Client::printRobots()
{
    std::vector<std::string> result;
    sql::ResultSet *robots = _db.getInfo("SELECT name FROM robot");

    while (robots->next())
    {
        result.push_back(robots->getString("name"));
    }
    int robotSize = result.size();

    for (int i = 0; i < robotSize; i++)
    {
        std::cout << result[i] << std::endl;
    }
}