page 50162 "Check List by Order No"
{
    PageType = List;
    Editable = false;
    Caption = 'Check List by Order No';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Header";
    CardPageId = "Order Worksheet Header";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Total Quantity"; "Total Quantity")
                {
                    ApplicationArea = All;
                }
                field(IsSameDayDelivery; IsSameDayDelivery)
                {
                    ApplicationArea = all;
                }
                field("Delivery Hours"; "Delivery Hours")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger onopenpage()
    var
        myInt: Integer;
    begin
        FilterGroup(2);
        SetRange("Pick /Pack Date", Today);
        FilterGroup(0);
    end;

    var
        myInt: Integer;

}