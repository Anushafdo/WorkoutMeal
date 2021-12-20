table 50152 "Customer Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; APIId; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; FirstName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; LastName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Tags; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Email; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; PhoneNo; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; country_name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; default; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; country; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; province; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; country_code; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; province_code; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Phone; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; first_name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Last_name; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(17; Company; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Add1; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Add2; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Zip; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; City; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(23; WasUpdated; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(24; Updated; Boolean)
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