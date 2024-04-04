#pragma once

#include <iostream>
#include <vector>

#include <cppconn/driver.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <mysql_connection.h>


class Database
{
private:
    sql::Driver *driver;
    sql::Connection *conn;
    sql::Statement *stmt;
    sql::ResultSet *res;

public:

    Database();
    ~Database();
    void connectionInit();

    std::vector<std::string> getInfo(std::string query);

};