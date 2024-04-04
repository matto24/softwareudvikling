#include <iostream>
#include "database.h"
#include "client.cpp"

int main()
{
    
    Database db;



    std::vector<std::string> result = db.getInfo("SELECT * FROM department");

    for (int i=0; i<result.size(); i++) {
        std::cout << result[i] << std::endl;
    }


    return 0;
}