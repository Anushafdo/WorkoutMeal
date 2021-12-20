tableextension 50211 SalesInvLine extends "Sales Invoice Line"
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

    }

    var
        myInt: Integer;
}