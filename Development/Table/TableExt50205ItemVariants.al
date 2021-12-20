tableextension 50205 ItemVariants extends "Item Variant"
{
    fields
    {
        // Add changes to table fields here
        field(50101; Total_Order; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Quantity where("No." = field("Item No."), "Variant Code" = field(Code), "Posting Date" = field("Date Filter")));
            Editable = false;
        }
        field(50102; Total_Inventery; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."), "Variant Code" = field(Code)));
            Editable = false;
        }
        field(50103; "Date Filter"; date)
        {
            FieldClass = FlowFilter;
        }
        field(50104; "Variant ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Barcode"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Shelf No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Shelf Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}