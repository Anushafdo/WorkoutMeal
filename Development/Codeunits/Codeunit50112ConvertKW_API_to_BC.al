codeunit 50112 ConvertKW_API_to_BC
{
    trigger OnRun()
    begin
        CreateItemForWorksheet;
        CreateCustForWorksheet;
        CreateOrderForWorksheet;
    end;

    var
        myInt: Integer;

    procedure CreateItemForWorksheet()
    var
        ProMaster: Record "Product Master";
        ProVarMaster: Record "Product Variants Master";
        Item: Record Item;
        NoSeries: Codeunit NoSeriesManagement;
        UOM: Record "Unit of Measure";
    begin
        ProMaster.Reset();
        if ProMaster.FindFirst() then
            repeat
                Item.Reset();
                Item.SetRange("No.", ProMaster.APIId);
                if not Item.FindFirst() then begin
                    Item.Init();
                    Item."No." := ProMaster.APIId;
                    Item.Insert(true);
                end;
                Item.Reset();
                Item.SetRange("No.", ProMaster.APIId);
                if Item.FindFirst() then begin
                    Item.Description := ProMaster.Title;
                    Item.Validate("Gen. Prod. Posting Group", 'RETAIL');
                    Item."VAT Prod. Posting Group" := 'GST10';
                    Item.Validate("Inventory Posting Group", 'RETAIL');
                    Item.Modify();
                end;
                ProMaster."Item No." := Item."No.";
                ProMaster.Modify();
                InsertItemVarient(ProMaster.APIId);
            until ProMaster.Next() = 0;
        Message('Data Updated');
    end;

    local procedure InsertItemVarient(APIID: Text[100])
    var
        ProVarMaster: Record "Product Variants Master";
        ItemVar: Record "Item Variant";
        UOM: Record "Unit of Measure";
        Item: Record Item;
    begin
        ProVarMaster.Reset();
        ProVarMaster.SetRange(ProductAPIId, APIID);
        if ProVarMaster.FindFirst() then
            repeat
                ItemVar.Reset();
                ItemVar.SetRange("Item No.", APIID);
                ItemVar.SetRange(Code, CopyStr(ProVarMaster.Title, 1, 10));
                if not ItemVar.FindFirst() then begin
                    ItemVar.Init();
                    ItemVar."Item No." := APIID;
                    ItemVar.Code := CopyStr(ProVarMaster.Title, 1, 10);
                    ItemVar.Insert(true);
                end;
                if Item.Get(APIID) then;
                ItemVar.Reset();
                ItemVar.SetRange("Item No.", APIID);
                ItemVar.SetRange(Code, CopyStr(ProVarMaster.Title, 1, 10));
                if ItemVar.FindFirst() then begin
                    //ItemVar.Description := Item.Description + ' - ' + ProVarMaster.Title;
                    ItemVar.Description := UpperCase(CopyStr(ProVarMaster.Title, 1, 1)) + ' - ' + Item.Description;
                    ItemVar."Description 2" := ProVarMaster.Title;
                    ItemVar."Variant ID" := ProVarMaster.VariantAPIId;
                    ItemVar.Barcode := ProVarMaster.Barcode;
                    ItemVar.Modify();
                end;
            until ProVarMaster.Next() = 0;
    end;

    procedure CreateCustForWorksheet()
    var
        CustMaster: Record "Customer Master";
        Cust: Record Customer;
        W: Dialog;
        Tot: Integer;
        i: Integer;
    begin
        W.Open('Line Insert #1#####');
        CustMaster.Reset();
        CustMaster.SetRange(Updated, true);
        if CustMaster.FindFirst() then begin
            Tot := CustMaster.Count;
            repeat
                i += 1;
                Cust.Reset();
                Cust.SetRange(Cust."No.", CustMaster.APIId);
                if not Cust.FindFirst() then begin
                    Cust.Init();
                    Cust."No." := CustMaster.APIId;
                    Cust.Insert(true);
                end;
                Cust.Reset();
                Cust.SetRange(Cust."No.", CustMaster.APIId);
                if Cust.FindFirst() then begin
                    Cust."Name" := CustMaster.firstname;
                    Cust."Name 2" := CustMaster.LastName;
                    Cust."E-Mail" := CustMaster.Email;
                    Cust."Phone No." := CustMaster.Phone;
                    Cust."Search Name" := CustMaster.Name;
                    Cust.County := CustMaster.country_name;
                    Cust.Address := CustMaster.Add1;
                    Cust."Address 2" := CustMaster.Add2;
                    Cust."Post Code" := CustMaster.Zip;
                    Cust.City := CustMaster.City;
                    Cust."Country/Region Code" := CustMaster.country_code;
                    Cust."Customer Posting Group" := 'DOMESTIC';
                    Cust."Gen. Bus. Posting Group" := 'DOMESTIC';
                    Cust.Modify();
                    CustMaster.Updated := false;
                    CustMaster."Customer No." := Cust."No.";
                    CustMaster.Modify();
                end;
                W.Update(1, format(i) + ' out of ' + Format(Tot));
            //W.Update(2, ROUND(i / Tot * 10000, 1));
            until CustMaster.Next() = 0;
        end;
        w.Close();
        Message('Data Updated');
    end;

    procedure CreateOrderForWorksheet()
    var
        SOHeader: Record "SO Header";
        Saleheader: Record "Sales Header";
        NoSeries: Codeunit NoSeriesManagement;
        Cust: Record "Customer";
        W: Dialog;
        Tot: Integer;
        i: Integer;
    begin
        W.Open('Line Insert #1#####');
        SOHeader.Reset();
        SOHeader.SetRange(Updated, true);
        SOHeader.SetFilter(CutomerAPIid, '<>%1', '');
        if SOHeader.FindFirst() then
            Tot := SOHeader.Count;
        repeat
            i += 1;
            Saleheader.Reset();
            Saleheader.SetRange("Document Type", Saleheader."Document Type"::Order);
            Saleheader.SetRange("No.", SOHeader.APIID);
            if not Saleheader.FindFirst() then begin
                Saleheader.Init();
                Saleheader."Document Type" := Saleheader."Document Type"::Order;
                Saleheader."No." := SOHeader.APIID;
                Saleheader.Insert();
            end;

            IF Cust.Get(SOHeader.CutomerAPIid) then begin
                Saleheader.Reset();
                Saleheader.SetRange("Document Type", Saleheader."Document Type"::Order);
                Saleheader.SetRange("No.", SOHeader.APIID);
                if Saleheader.FindFirst() then begin
                    Cust.Get(SOHeader.CutomerAPIid);
                    Saleheader.Validate("Sell-to Customer No.", Cust."No.");
                    Saleheader."Pick /Pack Date" := SOHeader.PickPackDate;
                    Saleheader."Delivery Date" := SOHeader.DeliveryDate;
                    Saleheader."Delivery Hours" := SOHeader.deliveryHours;
                    Saleheader.Barcode := SOHeader.Barcode;
                    Saleheader."Order No." := SOHeader.name;
                    Saleheader.IsSameDayDelivery := GetBooleanFromText(SOHeader.isSameDayDelivery);
                    Saleheader.Modify();
                end;

                //if Saleheader."Sell-to Customer No." <> '' then
                InsertSalesLine(SOHeader.APIID);
                SOHeader.Updated := false;
                SOHeader."Order No." := Saleheader."No.";
                SOHeader.Modify();
            end;
            W.Update(1, format(i) + ' out of ' + Format(Tot));
        //            W.Update(2, ROUND(i / Tot * 10000, 1));
        until SOHeader.Next() = 0;
        W.Close();
        Message('order created');
    end;

    procedure InsertSalesLine(APIid: Text[100])
    var
        SOLine: Record "SO Line";
        SOLine2: Record "SO Line";
        SaleLine: Record "Sales Line";
        NoSeries: Codeunit NoSeriesManagement;
        Cust: Record "Customer Master";
        Item: Record "Item";
        SOQty: decimal;
        Qty: decimal;
        ItemVar: Record "Item Variant";
        Grp: Text[100];
    begin
        SaleLine.Reset();
        SaleLine.SetRange(SaleLine."Document No.", APIid);
        if SaleLine.FindFirst() then
            SaleLine.DeleteAll();
        SOLine.Reset();
        SOLine.SetCurrentKey(product_id, variant_id);
        SOLine.SetRange(APIID, APIid);
        if SOLine.FindFirst() then
            repeat
                if Item.Get(SOLine.product_id) then begin
                    SOQty := 0;
                    SOLine2.Reset();
                    SOLine2.SetRange(APIID, APIid);
                    SOLine2.SetRange(SOLine2.variant_id, SOLine.variant_id);
                    if SOLine2.FindSet() then begin
                        SOLine2.CalcSums(quantity);
                        SOQty := SOLine2.quantity;
                    end;
                    if Grp <> SOLine.variant_id then begin
                        SaleLine.init;
                        SaleLine."Document Type" := SaleLine."Document Type"::Order;
                        SaleLine."Document No." := APIid;
                        SaleLine."Line No." := SaleLine."Line No." + 1;
                        SaleLine.type := SaleLine.type::Item;
                        //  Item.Get(SOLine.product_id);
                        SaleLine.Validate("No.", Item."No.");
                        ItemVar.Reset();
                        ItemVar.SetRange(ItemVar."Variant ID", SOLine.variant_id);
                        if ItemVar.FindFirst() then begin
                            SaleLine.Validate(SaleLine."Variant Code", ItemVar.Code);
                            SaleLine."Variant ID" := ItemVar."Variant ID";
                            SaleLine.Barcode := ItemVar.Barcode;
                        end;
                        SaleLine.Validate(Quantity, SOQty);
                        SaleLine.Validate("Unit Price", SOLine.price);
                        SaleLine.validate("Qty. to Ship", 0);
                        SaleLine.insert;
                    end;
                    Grp := SOLine.variant_id;
                end;
            until SOLine.Next() = 0;
    end;

    procedure CreateOrderForWorksheetOnebyOne(API: Text[100])
    var
        SOHeader: Record "SO Header";
        Saleheader: Record "Sales Header";
        NoSeries: Codeunit NoSeriesManagement;
        Cust: Record "Customer";
        W: Dialog;
        Tot: Integer;
        i: Integer;
    begin
        //W.Open('Line Insert #1#####\ @2@@@@@@@@@@@@@@@@@@@@');
        SOHeader.Reset();
        SOHeader.SetRange(APIid, API);
        SOHeader.SetRange(Updated, true);
        SOHeader.SetFilter(CutomerAPIid, '<>%1', '');
        if SOHeader.FindFirst() then
            //  Tot := SOHeader.Count;
            repeat
                //i += 1;
                Saleheader.Reset();
                Saleheader.SetRange("Document Type", Saleheader."Document Type"::Order);
                Saleheader.SetRange("No.", SOHeader.APIID);
                if not Saleheader.FindFirst() then begin
                    Saleheader.Init();
                    Saleheader."Document Type" := Saleheader."Document Type"::Order;
                    Saleheader."No." := SOHeader.APIID;
                    Saleheader.Insert();
                end;
                IF Cust.Get(SOHeader.CutomerAPIid) then begin
                    Saleheader.Reset();
                    Saleheader.SetRange("Document Type", Saleheader."Document Type"::Order);
                    Saleheader.SetRange("No.", SOHeader.APIID);
                    if Saleheader.FindFirst() then begin
                        Cust.Get(SOHeader.CutomerAPIid);
                        Saleheader.Validate("Sell-to Customer No.", Cust."No.");
                        Saleheader."Pick /Pack Date" := SOHeader.PickPackDate;
                        Saleheader."Delivery Date" := SOHeader.DeliveryDate;
                        Saleheader."Delivery Hours" := SOHeader.deliveryHours;
                        Saleheader.Barcode := SOHeader.Barcode;
                        Saleheader."Order No." := SOHeader.name;
                        Saleheader.IsSameDayDelivery := GetBooleanFromText(SOHeader.isSameDayDelivery);
                        Saleheader.Modify();
                        SOHeader.Updated := false;
                        SOHeader."Order No." := Saleheader."No.";
                        SOHeader.Modify();
                    end;

                    //if Saleheader."Sell-to Customer No." <> '' then
                    InsertSalesLine(SOHeader.APIID);
                end;
            //W.Update(1, format(i) + ' out of ' + Format(Tot));
            //W.Update(2, ROUND(i / Tot * 10000, 1));
            until SOHeader.Next() = 0;
        //W.Close();
        Message('order created');
    end;

    local procedure GetDateFromText(DateText: Text): Date
    var
        Year: Integer;
        Month: Integer;
        Day: Integer;
    begin
        EVALUATE(Year, COPYSTR(DateText, 1, 4));
        EVALUATE(Month, COPYSTR(DateText, 6, 2));
        EVALUATE(Day, COPYSTR(DateText, 9, 2));
        EXIT(DMY2DATE(Day, Month, Year));
    end;

    local procedure GetBooleanFromText(FlagText: Text): Boolean
    var
    begin
        if FlagText = 'true' then
            exit(true);
        exit(false);
    end;
}