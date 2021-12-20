page 50158 "Order Detail Run Sheet"
{
    PageType = List;
    Editable = false;
    Caption = 'Order Detail Run Sheet';
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
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Delivery Date"; "Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Pick /Pack Date"; "Pick /Pack Date")
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
                field("Total Line"; "Total Line")
                {
                    ApplicationArea = All;
                }

                field("Total Quantity"; "Total Quantity")
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
        SetRange("Pick /Pack Date", 0D, Today);

    end;

    var
        myInt: Integer;

}