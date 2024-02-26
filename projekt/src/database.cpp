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
        conn->setSchema("Restaurant");

        // Create a statement object
        stmt = conn->createStatement();

        res = stmt->executeQuery("SELECT * FROM menu");

        if (query == "item_name")
        {
            while (res->next())
            {
                result.push_back(res->getString("item_name"));
            }
        }

        if (query == "price")
        {
            while (res->next())
            {
                result.push_back(res->getString("price"));
            }
        }

        if (query == "description")
        {
            while (res->next())
            {
                result.push_back(res->getString("item_description"));
            }
        }
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
