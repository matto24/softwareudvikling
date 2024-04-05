#pragma once

#include <iostream>
#include <vector>

#include <cppconn/driver.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <mysql_connection.h>
#include <cppconn/prepared_statement.h>

class Database
{
private:
    sql::Driver *driver;
    sql::Connection *conn;
    sql::Statement *stmt;
    sql::ResultSet *res;
    sql::PreparedStatement *pstmt;

public:

    //Constructor
    Database();
    //Initialize connection
    void connectionInit();
    //Get info from database
    sql::ResultSet* getInfo(std::string query);

    //add task
    void addTask(std::string taskName);

    //add task to robot
    void addTaskToRobot(std::string robotName, std::string taskName);

    //remove task
    void removeTask();

    //Add robot
    void addRobot(std::string robotName);

    //remove robot
    void removeRobot(std::string robotName);
};