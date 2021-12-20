page 50102 "Scan Order"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    // SourceTable = TableName;

    layout
    {
        area(Content)
        {
            group("Sales Order Scanner")
            {
                field("Scan Order"; ScanOrder)
                {
                    ApplicationArea = All;
                    trigger onvalidate()
                    var
                        SalesHeader: Record "Sales Header";
                        SalesLine: Record "Sales Line";
                    begin
                        SalesHeader.Reset();
                        SalesHeader.SetRange(Barcode, ScanOrder);
                        if not SalesHeader.FindFirst() then
                            Error('No Order Found');

                        SalesHeader.Reset();
                        SalesHeader.SetRange(Barcode, ScanOrder);
                        if SalesHeader.FindFirst() then begin
                            SalesHeader."Picked By" := UserId;
                            SalesHeader.Modify();
                            Page.run(50105, SalesHeader);
                            Clear(ScanOrder);
                        end;
                    end;

                }
            }
        }
    }



    var
        ScanOrder: Text[100];
}