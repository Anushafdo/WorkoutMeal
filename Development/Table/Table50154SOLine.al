table 50154 "SO Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; APIid; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(2; id; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; variant_id; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(4; fulfillment_service; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; fulfillment_status; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; fulfillable_quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; requires_shipping; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; taxable; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; name; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(10; price_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; rate_tax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; title_tax; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; discount_allocations; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; title; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; pre_tax_price; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; grams; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; sku; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; product_id; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; gift_card; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; name_property; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; value_Property; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; total_discount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; applied_discount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; variant_title; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; vendor; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; APIid, id)
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