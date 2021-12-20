page 50106 "Order Worksheet Line"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Line";
    SourceTableView = where("Order Picked" = filter(false));
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(OrderLine)
            {
                field("Variant ID"; "Variant ID")
                {
                    ApplicationArea = All;
                    StyleExpr = MyStyleExpr;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    StyleExpr = MyStyleExpr;
                    Editable = false;
                }
                field("Shelf No."; "Shelf No.")
                {
                    ApplicationArea = All;
                    StyleExpr = MyStyleExpr;
                    Editable = false;
                }
                field("Shelf Name"; "Shelf Name")
                {
                    ApplicationArea = All;
                    StyleExpr = MyStyleExpr;
                    Editable = false;
                }

                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    StyleExpr = MyStyleExpr;
                    Editable = false;
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                    ApplicationArea = All;
                    StyleExpr = MyStyleExpr;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    var

    begin
        SetCurrentKey("Shelf No.");
    end;

    trigger onaftergetrecord()
    var

    begin

        if Cust.get("Bill-to Customer No.") then;
        SaleHeader.Reset();
        SaleHeader.SetRange("No.", "Document No.");
        if SaleHeader.FindFirst() then;
        PickedBy := SaleHeader."Picked By";
        MyStyleExpr := 'Standard';
        if (Quantity = "Qty. to Ship") then
            MyStyleExpr := 'Favorable';
    end;

    var
        ScanItem: Text[100];
        Cust: Record Customer;
        SaleHeader: Record "Sales Header";
        MyStyleExpr: Text[50];
        PickedBy: Text[100];

}