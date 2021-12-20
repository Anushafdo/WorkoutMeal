page 50161 "Order Picked Report"
{
    PageType = List;
    Editable = false;
    Caption = 'Order Picked Report';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Header";
    //SourceTableView = where(Status = filter('Released'), "Picked By" = filter(<> ''));
    CardPageId = "Order Worksheet Header";
    Permissions = TableData "Sales Invoice Header" = RIMD;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Order No."; "OrderNo.")
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
                field("Picked By"; "Picked By")
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
            action(Sync)
            {
                ApplicationArea = All;
                AccessByPermission = TableData "Sales Invoice Header" = RIMD;
                Visible = false;
                trigger OnAction()
                var
                    SOHeader: Record "SO Header";
                    SIH: Record "Sales Invoice Header";
                begin
                    SIH.Reset();
                    SIH.CopyFilters(Rec);
                    if SIH.FindFirst() then
                        repeat
                            SOHeader.Reset();
                            SOHeader.SetRange(APIID, SIH."Order No.");
                            if SOHeader.FindFirst() then begin
                                SIH."OrderNo." := SOHeader.name;
                                SIH."Delivery Date" := SOHeader.DeliveryDate;
                                SIH."Pick /Pack Date" := SOHeader.PickPackDate;
                                //SIH.Modify();
                            end;
                        until SIH.Next() = 0;
                end;
            }
        }
    }
    trigger onopenpage()
    var
        myInt: Integer;
    begin


    end;

    var
        myInt: Integer;

}