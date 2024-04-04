#include <iostream>
#include "database.h"

Database::Database()
{
    driver = nullptr;
    conn = nullptr;
    stmt = nullptr;
    res = nullptr;
    pstmt = nullptr;
}

void Database::connectionInit()
{
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

sql::ResultSet *Database::getInfo(std::string query)
{
    try
    {
        // Create a statement object
        stmt = conn->createStatement();

        // Execute the query
        res = stmt->executeQuery(query);
    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }

    // Return result
    return res;
}

void Database::addTask(std::string taskName) {
    try
    {
        //Prepare statement
        pstmt = conn->prepareStatement("INSERT INTO task(name) VALUES(?)");
        //Replace ? with taskname
        pstmt -> setString(1, taskName);
        //Execute update
        pstmt->executeUpdate();

    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }
}

void Database::removeTask() {
     try
    {
        //Find first task
        res = getInfo("SELECT name FROM task LIMIT 1");
        if (res->next()) {
            std::string taskName = res->getString("name");
            std::cout << "Task completed: " << res->getString("name") << std::endl;

            //Prepare statement
            pstmt = conn->prepareStatement("DELETE FROM task WHERE name = ?");
            //Replace ? with taskname
            pstmt -> setString(1, taskName);
            //Execute update
            pstmt->executeUpdate();
        } else {
            std::cout << "No tasks found" << std::endl;
        }


    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }
}  