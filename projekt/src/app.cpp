#include "app.h"
#include "mainFrame.h"
#include <wx/wx.h>

wxIMPLEMENT_APP(App);

bool App::OnInit()
{
    //Create main window
    MainFrame *frame = new MainFrame("My Restaurant Menu");
    //Set size of window
    frame->SetClientSize(800, 600);
    //Center window on screen
    frame->Center();
    //Show window
    frame->Show(true);
    return true;
}