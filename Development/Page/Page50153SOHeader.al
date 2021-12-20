page 50153 "SO Header"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SO Header";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(APIID; APIID)
                {
                    ApplicationArea = All;
                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                }
                field(CutomerAPIid; CutomerAPIid)
                {
                    ApplicationArea = All;
                }
                field(WasUpdated; WasUpdated)
                {
                    ApplicationArea = all;
                }
                field(Barcode; Barcode)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Updated; Updated)
                {
                    ApplicationArea = all;
                }
                field("Delivery Date"; "DeliveryDate")
                {
                    ApplicationArea = all;
                }
                field("Pick /Pack Date"; "PickPackDate")
                {
                    ApplicationArea = all;
                }
                field(deliveryHours; deliveryHours)
                {
                    ApplicationArea = All;
                }
                field(isSameDayDelivery; isSameDayDelivery)
                {
                    ApplicationArea = All;
                }
                field(CreatedDate; CreatedDate)
                {
                    ApplicationArea = all;
                }
                field(Note; Note)
                {
                    ApplicationArea = All;
                }
                field(financialStatus; financialStatus)
                {
                    ApplicationArea = All;
                }
                field(subtotalPrice; subtotalPrice)
                {
                    ApplicationArea = All;
                }
                field(totalDiscounts; totalDiscounts)
                {
                    ApplicationArea = All;
                }
                field(totalTax; totalTax)
                {
                    ApplicationArea = All;
                }
                field(totalPrice; totalPrice)
                {
                    ApplicationArea = All;
                }
                field(location; location)
                {
                    ApplicationArea = All;
                }


                field(id_Cust; id_Cust)
                {
                    ApplicationArea = All;
                }
                field(email_Cust; email_Cust)
                {
                    ApplicationArea = All;
                }

                field(name_Ship; name_Ship)
                {
                    ApplicationArea = All;
                }
                field(latitude_Ship; latitude_Ship)
                {
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("KitchenWare API")
            {
                Caption = 'KitchenWare API';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Email;
                trigger onaction()
                var
                    KitchenWare: Codeunit "Kitchenware APIS";
                begin
                    KitchenWare.GetSOHeaderAPIData();
                end;
            }

            action("SO Line")
            {
                Caption = 'SO Line';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Email;
                RunObject = page "SO Line";
                RunPageLink = APIid = field(APIID);
            }
            action("Make Order")
            {
                Caption = 'Make Order';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Item;
                trigger onaction()
                var
                    ConvertKW_API_to_BC: Codeunit ConvertKW_API_to_BC;
                    SOheader: Record "SO Header";
                    W: Dialog;
                    i: Integer;
                    Tot: Integer;
                begin
                    W.Open('Line Insert #1#####');
                    CurrPage.SETSELECTIONFILTER(SOheader);
                    if SOheader.FindFirst() then
                        Tot := SOheader.Count;
                    repeat
                        i += 1;

                        ConvertKW_API_to_BC.CreateOrderForWorksheetOnebyOne(SOheader.APIID);

                        W.Update(1, format(i) + ' out of ' + Format(Tot));
                    until SOheader.Next() = 0;
                    W.Close();


                end;
            }
            action("PostAPI")
            {
                Caption = 'Post API';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Item;
                trigger onaction()
                var
                    KitchenWare: Codeunit "Kitchenware APIS";
                begin
                    KitchenWare.TestRestAPI2(APIID, 'order');
                end;
            }
            action("Get API Data By Selection")
            {
                Caption = 'Get API Data By Selection';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Email;
                trigger onaction()
                var
                    KitchenWare: Codeunit "Kitchenware APIS";
                    SOheader: Record "SO Header";
                    W: Dialog;
                    i: Integer;
                    Tot: Integer;

                begin
                    W.Open('Line Insert #1#####');
                    CurrPage.SETSELECTIONFILTER(SOheader);
                    if SOheader.FindFirst() then
                        Tot := SOheader.Count;
                    repeat
                        i += 1;
                        KitchenWare.OneByOneGetSOHeaderAPIDataByAPIid(SOheader.APIID);
                        W.Update(1, format(i) + ' out of ' + Format(Tot));
                    until SOheader.Next() = 0;
                    W.Close();
                end;
            }
            action("Update Barcode")
            {
                Caption = 'Update Barcode';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Email;
                trigger onaction()
                var
                    KitchenWare: Codeunit "Kitchenware APIS";
                    SOheader: Record "SO Header";
                    W: Dialog;
                    i: Integer;
                    Tot: Integer;

                begin
                    W.Open('Line Insert #1#####');
                    CurrPage.SETSELECTIONFILTER(SOheader);
                    if SOheader.FindFirst() then
                        Tot := SOheader.Count;
                    repeat
                        i += 1;
                        KitchenWare.UpdateBarcode(SOheader.APIID);
                        W.Update(1, format(i) + ' out of ' + Format(Tot));
                    until SOheader.Next() = 0;
                    W.Close();
                end;
            }
            action("Delete PickDate till 12 mar")
            {
                Caption = 'Delete PickDate till 12 mar';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Email;
                trigger onaction()
                var
                    KitchenWare: Codeunit "Kitchenware APIS";
                    SOheader: Record "SO Header";
                    SOLine: Record "SO Line";
                    W: Dialog;
                    i: Integer;
                    Tot: Integer;
                    saleHeader: Record "Sales Header";
                    SaleLine: Record "Sales Line";

                begin
                    W.Open('Line Insert #1#####');
                    CurrPage.SETSELECTIONFILTER(SOheader);
                    SOheader.SetFilter(PickPackDate, '<=%1', 20210312D);
                    if SOheader.FindFirst() then
                        Tot := SOheader.Count;
                    repeat
                        i += 1;
                        saleHeader.Reset();
                        saleHeader.SetRange("No.", SOheader.APIID);
                        if saleHeader.FindFirst() then
                            saleHeader.Delete();
                        SaleLine.Reset();
                        SaleLine.SetRange("Document No.", SOheader.APIID);
                        if SaleLine.FindFirst() then
                            SaleLine.DeleteAll();
                        SOheader.Delete();

                        SOLine.Reset();
                        SOLine.SetRange(APIID, SOheader.APIID);
                        if SOLine.FindFirst() then
                            SOLine.DeleteAll();
                        W.Update(1, format(i) + ' out of ' + Format(Tot));
                    until SOheader.Next() = 0;
                    W.Close();
                end;
            }
            action("Update Barcode in SalesLine")
            {
                Caption = 'Update Barcode in SalesLine';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Email;
                trigger onaction()
                var
                    SalesLine: Record "Sales Line";
                    W: Dialog;
                    i: Integer;
                    Tot: Integer;
                    ItemVariant: Record "Item Variant";
                begin
                    W.Open('Line Insert #1#####');

                    SalesLine.Reset();
                    SalesLine.SetRange(Barcode, '');
                    if SalesLine.FindFirst() then
                        Tot := SalesLine.Count;
                    repeat
                        i += 1;
                        ItemVariant.Reset();
                        ItemVariant.SetRange(code, SalesLine."Variant Code");
                        ItemVariant.SetRange("Item No.", SalesLine."No.");
                        if ItemVariant.FindFirst() then;
                        SalesLine.Barcode := ItemVariant.Barcode;
                        SalesLine.Modify();
                        W.Update(1, format(i) + ' out of ' + Format(Tot));
                    until SalesLine.Next() = 0;
                    W.Close();
                end;
            }
        }
    }

}