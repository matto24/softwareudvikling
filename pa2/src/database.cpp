#include <iostream>
#include "database.h"


Database::Database() {
    driver = nullptr;
    conn = nullptr;
    stmt = nullptr;
    res = nullptr;
}

Database::~Database() {
    delete res;
    delete stmt;
    delete conn;
}


void Database::connectionInit() {
    try
    {
        // Create a connection
        driver = get_driver_instance();
        conn =
            driver->connect("tcp://127.0.0.1:3306", "root", "Scrambler3Starting");

        // Specify the database to use
        conn->setSchema("robot_worker");

    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }

}



std::vector<std::string> Database::getInfo(std::string query)
{
    std::vector<std::string> result;

    try
    {
        // Create a statement object
        stmt = conn->createStatement();

        // Execute the query
        res = stmt->executeQuery(query);

        while(res->next())
        {
            result.push_back(res->getString("name"));
        }

    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }

    // Return result
    return result;
}
