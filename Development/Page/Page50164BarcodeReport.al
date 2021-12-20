page 50164 "Barcode Report"
{
    PageType = List;
    Editable = false;
    Caption = 'Barcode Report';
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


                field("Business Name"; 'Workout Meals')
                {
                    ApplicationArea = All;
                }
                field("Pick /Pack Date"; "Pick /Pack Date")
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
                field("Total Meal"; "Total Quantity")
                {
                    Caption = 'Total Meal';
                    ApplicationArea = All;
                }
                field("Total Snacks"; "Total Line")
                {
                    Caption = 'Total Snacks';
                    ApplicationArea = All;
                }
                field("Delivery Time"; "Delivery Hours")
                {
                    ApplicationArea = All;
                }

                field("Delivery Instructions"; '')
                {
                    ApplicationArea = All;
                }
                field("Region Code"; "Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                }
                field(Barcode; Barcode)
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