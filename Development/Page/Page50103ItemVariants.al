pageextension 50103 IremVarients extends "Item Variants"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Variant ID"; "Variant ID")
            {
                ApplicationArea = all;
            }
            field(Barcode; Barcode)
            {
                ApplicationArea = all;
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

    var
        myInt: Integer;
}