table 50153 "SO Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; APIID; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; CutomerAPIid; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Note; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5; financialStatus; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; subtotalPrice; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; totalDiscounts; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; totalTax; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; totalPrice; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; location; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; deliveryHours; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12; isSameDayDelivery; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; name_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; latitude_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; longitude_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; country_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; province_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; country_code_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(19; province_code_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; phone_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; first_name_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; last_name_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(23; company_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; address1_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; address2_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; zip_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(27; id_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(28; email_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(29; created_at_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; updated_at_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; accepts_marketing_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; first_name_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(33; last_name_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(34; orders_count_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(35; state_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; total_spent_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(37; note_Cust; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(38; phone_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(39; tags_Cust; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(40; city_Ship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header";
        }
        field(42; WasUpdated; Text[10])
        {
            DataClassification = ToBeClassified;
        }

        field(43; Updated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "DeliveryDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "PickPackDate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Barcode"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "CreatedDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; APIID)
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