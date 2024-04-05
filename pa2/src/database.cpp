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
        //Replace tcp, username, and password with your own
        conn = driver->connect("tcp://127.0.0.1:3306", "root", "password");

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

void Database::addTask(std::string taskName)
{
    try
    {
        // Prepare statement
        pstmt = conn->prepareStatement("INSERT INTO task(name) VALUES(?)");
        // Replace ? with taskname
        pstmt->setString(1, taskName);
        // Execute update
        pstmt->executeUpdate();
    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }
}

void Database::addTaskToRobot(std::string robotName, std::string taskName)
{
    try
    {
        res = getInfo("SELECT name FROM task WHERE available = TRUE LIMIT 1");
        if (res->next())
        {
            // Prepare statement
            pstmt = conn->prepareStatement("UPDATE robot SET current_task = ? WHERE name = ?");
            // Replace ?? with taskname
            pstmt->setString(1, taskName);
            pstmt->setString(2, robotName);
            // Execute update
            pstmt->executeUpdate();

            pstmt = conn->prepareStatement("UPDATE task SET available = FALSE WHERE name = ?");
            pstmt->setString(1, taskName);
            pstmt->executeUpdate();
        } else {
            std::cout << "No tasks available" << std::endl;
        }
    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }
}

void Database::removeTask(std::string taskName)
{
    try
    {
            std::cout << "Task completed: " << taskName << std::endl;

            // Prepare statement
            pstmt = conn->prepareStatement("DELETE FROM task WHERE name = ?");
            // Replace ? with taskname
            pstmt->setString(1, taskName);
            // Execute update
            pstmt->executeUpdate();
        }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }
}

void Database::addRobot(std::string robotName)
{
    try
    {
        // Prepare statement
        pstmt = conn->prepareStatement("INSERT INTO robot(name) VALUES(?)");
        // Replace ? with taskname
        pstmt->setString(1, robotName);
        // Execute update
        pstmt->executeUpdate();
    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }
}

void Database::removeRobot(std::string robotName)
{
    try
    {
        std::cout << "delete robot: " << robotName << std::endl;
        // Prepare statement
        pstmt = conn->prepareStatement("DELETE FROM robot WHERE name = ?");
        // Replace ? with taskname
        pstmt->setString(1, robotName);
        // Execute update
        pstmt->executeUpdate();
    }
    catch (sql::SQLException &e)
    {
        // Error handling
        std::cout << "Error: " << e.what() << std::endl;
    }
}