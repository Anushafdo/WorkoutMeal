codeunit 50113 "Sales Invoice Posting Process"
{
    trigger OnRun()
    begin
        AutoPosing();
        AutoEmailForJobQueueError();
    end;

    procedure AutoPosing()
    var
        SalesHeader: Record "Sales Header";
        PostingError: Record "Posting Error";
    begin
        SalesHeader.Reset();
        SalesHeader.SetCurrentKey("No.");
        SalesHeader.SetRange(Status, SalesHeader.Status::Released);
        if SalesHeader.FindFirst() then
            repeat
                if QtyisEqualtoQtytoShip(SalesHeader) then begin
                    SalesHeader.Ship := true;
                    SalesHeader.Invoice := true;
                    Commit();
                    IF NOT CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader) then begin
                        PostingError.INIT;
                        PostingError."No." := SalesHeader."No.";
                        //PostingError."Line No.":=1;                    
                        PostingError."Error Text" := COPYSTR(GETLASTERRORTEXT, 1, 500);
                        PostingError."Last Error Date" := WorkDate();
                        IF NOT PostingError.INSERT THEN
                            PostingError.MODIFY();
                    end else begin
                        PostingError.Reset();
                        PostingError.SetRange("No.", SalesHeader."No.");
                        if PostingError.FindFirst() then begin
                            PostingError.Delete();
                        end;

                    end;

                end;
            until SalesHeader.Next() = 0;

    end;

    procedure QtyisEqualtoQtytoShip(SH: Record "Sales Header"): Boolean
    var
        SL: Record "Sales Line";
    begin
        SL.Reset;
        SL.SetRange("Document No.", SH."No.");
        if SL.FindFirst() then
            repeat
                if SL.Quantity <> SL."Qty. to Ship" then
                    exit(false);
            until SL.Next() = 0;
        exit(true);
    end;

    procedure AutoEmailForJobQueueError()
    var
        SMTPMailSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        ToMail: List of [text];
        Subject: Text;
        Mailsent: Boolean;
        CC: List of [text];
        JobQueEntry: Record "Job Queue Entry";
    begin
        JobQueEntry.Reset();
        JobQueEntry.SetRange(Status, JobQueEntry.Status::Error);
        JobQueEntry.SetFilter("Object ID to Run", '50111|50112');
        if NOT JobQueEntry.FindFirst() then exit;
        Subject := '';
        Clear(ToMail);
        Mailsent := false;
        ToMail.Add('abby@basketgroup.com.au');
        ToMail.Add('srikant@onshoring.com.au');
        ToMail.Add('gabriele@belandbrio.com.au');
        ToMail.Add('enicoletti@basketgroup.com.au');
        cc.Add('pawanreallife@gmail.com');
        Subject := 'Kitchenware Job Queue Error';
        clear(SMTPMail);
        SMTPMailSetup.GET;
        SMTPMail.CreateMessage(SMTPMailSetup."User ID", SMTPMailSetup."User ID", ToMail, Subject, '', TRUE);
        SMTPMail.AppendBody('Hi');
        SMTPMail.AppendBody('<br></br>');
        SMTPMail.AppendBody('The Job Queue (' + format(JobQueEntry."Object Type to Run") + ' ' + format(JobQueEntry."Object ID to Run") + ') has stopped');
        SMTPMail.AddBCC(CC);
        SMTPMail.Send;

    end;


    var
        myInt: Integer;
}