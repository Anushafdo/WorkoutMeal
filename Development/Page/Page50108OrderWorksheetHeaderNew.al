/*
page 50108 "Order Worksheet Header New"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Header";

    layout
    {
        area(Content)
        {
            group(ScanOrder)
            {

                field("Scan Item"; "Scan Item")
                {
                    ApplicationArea = all;

                    trigger onvalidate()
                    var
                        SalesLine: Record "Sales Line";
                        SalesHeader: Record "Sales Header";
                        ScanPage: Page "Scan Order";
                        DocNo: Code[20];
                    begin
                        //TestField("Picked By");
                        SalesLine.reset;
                        SalesLine.setrange(SalesLine."Document No.", "No.");
                        SalesLine.SetRange(Barcode, "Scan Item");
                        if not SalesLine.FindFirst() then
                            Error('Variant not found.');

                        SalesLine.reset;
                        SalesLine.setrange(SalesLine."Document No.", "No.");
                        SalesLine.SetRange(Barcode, "Scan Item");
                        SalesLine.SetRange("Order Picked", false);
                        if not SalesLine.FindFirst() then
                            Error('Variant already picked.');

                        SalesLine.reset;
                        SalesLine.setrange(SalesLine."Document No.", "No.");
                        SalesLine.SetRange(Barcode, "Scan Item");
                        SalesLine.SetRange("Order Picked", false);
                        if SalesLine.FindFirst() then begin
                            SalesLine."Qty. to Ship" += 1;
                            SalesLine.Validate("Qty. to Ship");
                            SalesLine.Modify();
                            "Scan Item" := '';
                            //clear(ScanItem);
                        end;

                        DocNo := "No.";
                        SalesLine.reset;
                        SalesLine.setrange(SalesLine."Document No.", "No.");
                        if SalesLine.FindFirst() then begin
                            SalesLine.CalcSums(Quantity, "Qty. to Ship");
                            if SalesLine."Qty. to Ship" = SalesLine.Quantity then begin
                                Status := Status::Released;
                                "System Picked Date" := Today;
                                modify;
                                Message('Order Picked Quantity %1', SalesLine.Quantity);
                                ScanPage.Run();
                            end;
                            if SalesLine."Qty. to Ship" <> SalesLine.Quantity then begin
                                CurrPage.Close();
                                SalesHeader.Reset();
                                SalesHeader.SetRange("No.", DocNo);
                                if SalesHeader.FindFirst() then
                                    Page.Run(50108, SalesHeader, SalesHeader."Scan Item");
                            end;

                        end;


                    end;
                }
                field("Picked By"; "Picked By")
                {
                    ApplicationArea = all;
                    TableRelation = "Salesperson/Purchaser";
                    Visible = false;
                }


            }
            part(PartName; "Order Worksheet Line")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }



    var
    // ScanItem: Text[100];


}
*/