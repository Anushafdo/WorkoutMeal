table 50155 "Ingredient Master"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; Product_API_Id; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Variant_API_Id; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Title; text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(4; Type; text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(5; Weight; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(6; UOM; Code[10])
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(PK; Product_API_Id, Variant_API_Id, Type)
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
