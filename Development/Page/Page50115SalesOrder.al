pageextension 50115 SalesOrder extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document Date")
        {
            field("Order No."; "Order No.")
            {
                ApplicationArea = all;
            }
            field("Delivery Hours"; "Delivery Hours")
            {
                ApplicationArea = all;
            }
            field(IsSameDayDelivery; IsSameDayDelivery)
            {
                ApplicationArea = all;
            }
            field("Delivery Date"; "Delivery Date")
            {
                ApplicationArea = all;
            }
            field("Pick /Pack Date"; "Pick /Pack Date")
            {
                ApplicationArea = all;
            }
            field(Barcode; Barcode)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Picked By"; "Picked By")
            {
                ApplicationArea = all;
            }
            field("System Picked Date"; "System Picked Date")
            {
                ApplicationArea = all;
                Editable = false;
            }


        }
    }

    var
        myInt: Integer;
        ScanItem: Text[100];
}