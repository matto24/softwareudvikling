#include <iostream>
#include "database.h"

std::vector<std::string> Database::getInfo(std::string query)
{
    sql::Driver *driver;
    sql::Connection *conn;
    sql::Statement *stmt;
    sql::ResultSet *res;
    std::vector<std::string> result;

    try
    {
        // Create a connection
        driver = get_driver_instance();
        conn =
            driver->connect("tcp://127.0.0.1:3306", "root", "Scrambler3Starting");

        // Specify the database to use
        conn->setSchema("Company");

        // Create a statement object
        stmt = conn->createStatement();

        // Execute the query
        res = stmt->executeQuery("SELECT * FROM menu");

    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }

    // Clean up
    delete res;
    delete stmt;
    delete conn;

    // Return result
    return result;
}
