tableextension 50204 SalesHeader extends "Sales Header"
{
    DataCaptionFields = "Order No.";
    fields
    {
        // Add changes to table fields here
        field(50100; "Delivery Hours"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "IsSameDayDelivery"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "Pick /Pack Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "Total Line"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Line" where("Document No." = field("No."), "Document Type" = field("Document Type")));
            Editable = false;
        }
        field(50105; "Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".quantity where("Document No." = field("No."), "Document Type" = field("Document Type")));
            Editable = false;
        }
        field(50106; "Barcode"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Picked By"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "System Picked Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Scan Item"; text[100])
        {
            DataClassification = ToBeClassified;
        }

    }


    var
        myInt: Integer;
}