table 50151 "Product Variants Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ProductAPIId; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; VariantAPIId; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Price; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Ingredients; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(5; TotalWeight; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Title; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Item No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Barcode"; text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; ProductAPIId, VariantAPIId)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}