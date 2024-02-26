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
    
public:
    std::vector<std::string> getInfo(std::string query);
};