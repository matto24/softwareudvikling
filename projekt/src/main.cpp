#include <iostream>


#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h> 

//Include wxwidgets
#include <wx/wx.h>


using namespace std;
using namespace sql;

int main() {
    sql::Driver *driver;
    sql::Connection *conn;
    sql::Statement *stmt;
    sql::ResultSet *res;

    try {
        // Create a connection
        driver = get_driver_instance();
        conn = driver->connect("tcp://127.0.0.1:3306", "root", "Scrambler3Starting");

        // Specify the database to use
        conn->setSchema("Restaurant"); 

        // Create a statement object
        stmt = conn->createStatement();

        // Execute a query
        res = stmt->executeQuery("SELECT * FROM customers"); 

        // Iterate through the result set
        while (res->next()) {
           cout << "Customer: " << res->getString("first_name") 
                << " " << res->getString("last_name") << endl;
        }

        // Clean up
        delete res;
        delete stmt;
        delete conn;

    } catch (SQLException &e) {
        // Error handling
        cout << "Error: " << e.what() << endl;
        return 1; // Indicate error
    }

    return 0;  // Successful execution
}