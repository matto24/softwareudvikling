#pragma once
#include <wx/wx.h>
#include <wx/listctrl.h>

class MainFrame : public wxFrame
{
    public:
        MainFrame(const wxString& title);
        void displayMenu();

    private:
        wxListView *listView;
};