pageextension 50116 SalesLine extends "Sales Order Subform"

{

    layout
    {

        // Add changes to page layout here
        addafter("Variant Code")
        {
            field("Variant ID"; "Variant ID")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Barcode; Barcode)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Shelf No."; "Shelf No.")
            {
                ApplicationArea = all;
            }
            field("Shelf Name"; "Shelf Name")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        Error('You cannot delete the record.');
    end;

    var
        myInt: Integer;
}