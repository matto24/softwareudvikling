#include <wx/wx.h>
#include <wx/listbox.h>

#include "mainFrame.h"
#include "database.h"


//No parent window, wxID_ANY is a unique identifier
MainFrame::MainFrame(const wxString& title) : wxFrame(NULL, wxID_ANY, title)
{
    wxMenu *menuFile = new wxMenu;
    menuFile->Append(wxID_EXIT);
    wxMenuBar *menuBar = new wxMenuBar;
    menuBar->Append(menuFile, "&File");
    SetMenuBar(menuBar);
    CreateStatusBar();  
    SetStatusText("Welcome to my Restaurant!");

    //Create a panel to hold the list view
    wxPanel *panel = new wxPanel(this);
    //Create a list view to display the menu items
    listView = new wxListView(panel);
    //Add two columns to the list view
    listView->AppendColumn("Menu Item", wxLIST_FORMAT_LEFT, 150);
    listView->AppendColumn("Price", wxLIST_FORMAT_LEFT, 150);
    listView->AppendColumn("Description", wxLIST_FORMAT_LEFT, 300);

    //Make a sizer that will automatically resize the list view
    auto sizer = new wxBoxSizer(wxVERTICAL);
    //The add function takes the widget to add, a proportion, a flag, and a border
    sizer->Add(listView, 1, wxALL | wxEXPAND,0);
    //Sets the sizer for the panel and fits the panel to the sizer
    panel->SetSizerAndFit(sizer);

    //Display the menu
    displayMenu();
}


void MainFrame::displayMenu() {
    //Create instance of database class
    Database db;
    //Save results from database into a vector of strings
    std::vector<std::string> itemName = db.getInfo("item_name");
    std::vector<std::string> price = db.getInfo("price");
    std::vector<std::string> description = db.getInfo("description");
    //Iterate through the vector of strings
    for (int i = 0; i < itemName.size(); i++) {
        //Split the string into two parts
        std::string item = itemName[i];
        std::string cost = price[i];
        std::string desc = description[i];
        //Add the two parts to the list view
        listView->InsertItem(i, item);
        listView->SetItem(i, 1, cost);
        listView->SetItem(i, 2, desc);
    }
    std::cout << description[6] << std::endl;
}