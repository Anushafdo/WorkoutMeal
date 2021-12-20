table 50150 "Product Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; APIId; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Title; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Tags; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(7; WasUpdated; Text[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; APIId)
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