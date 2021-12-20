page 50163 "Driver Manifest"
{
    PageType = List;
    Editable = false;
    Caption = 'Driver Manifest';
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
                    ApplicationArea = all;
                }
                field("Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Suburb/City"; "Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "Sell-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("State"; "Ship-to County")
                {
                    ApplicationArea = All;
                }
                field("Time Window Start"; '')
                {
                    ApplicationArea = All;
                }
                field("Time Window End"; '')
                {
                    ApplicationArea = All;
                }

                field("Delivery Instructions"; '')
                {
                    ApplicationArea = All;
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