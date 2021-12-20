pageextension 50101 "OngoingDeliveryPage" extends "SO Processor Activities"
{
    layout
    {
        addafter("Sales Orders - Open")
        {
            field("Order to Pick Today"; "Order to Pick Today")
            {
                ApplicationArea = all;
                DrillDownPageId = "Order Detail Run Sheet";

            }
            field("Same Day Delivery AM"; "Same Day Delivery AM")
            {
                ApplicationArea = all;
                DrillDownPageId = "Order Detail Run Sheet";
            }
            field("Same Day Delivery PM"; "Same Day Delivery PM")
            {
                ApplicationArea = all;
                DrillDownPageId = "Order Detail Run Sheet";
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger onopenpage()
    var
        myInt: Integer;
    begin
        SetRange("Pick Date Filter", 0D, Today);
    end;

    var
        myInt: Integer;
}