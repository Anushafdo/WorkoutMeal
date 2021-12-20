page 50166 "Scan Order RoleCenter"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {

        }
    }

    actions
    {

        area(Sections)
        {
            group(Sales)
            {
                action(ScanOrder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scan Orders';
                    Image = "Order";
                    RunObject = Page "Scan Order";

                }
            }
        }

    }
}