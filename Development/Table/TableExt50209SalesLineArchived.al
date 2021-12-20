tableextension 50209 SalesLineArch extends "Sales Line Archive"
{
    fields
    {
        // Add changes to table fields here
        field(50100; "Barcode"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Variant ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger onvalidate()
            var
                ItemVar: Record "Item Variant";
            begin
                ItemVar.Reset();
                ItemVar.SetRange("Variant ID", "Variant ID");
                if ItemVar.FindFirst() then begin
                    Barcode := ItemVar.Barcode;
                end;
            end;
        }
        field(50102; "Shelf No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Shelf Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Order Picked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        modify("Variant Code")
        {
            trigger onaftervalidate()
            var
                ItemVar: Record "Item Variant";
            begin
                ItemVar.Reset();
                ItemVar.SetRange("Item No.", "No.");
                ItemVar.SetRange(Code, "Variant Code");
                if ItemVar.FindFirst() then begin
                    "Variant ID" := ItemVar."Variant ID";
                    Barcode := ItemVar.Barcode;
                    "Shelf No." := ItemVar."Shelf No.";
                    "Shelf Name" := ItemVar."Shelf Name";
                end;
            end;
        }
        modify("No.")
        {
            trigger onaftervalidate()
            var
                Item: Record "Item";
            begin
                if Item.Get("No.") then;

            end;
        }
        modify("Qty. to Ship")
        {
            trigger onaftervalidate()
            var

            begin
                if Quantity = "Qty. to Ship" then
                    "Order Picked" := true
                else
                    "Order Picked" := false;

            end;
        }

    }

    var
        myInt: Integer;
}