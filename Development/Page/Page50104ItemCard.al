pageextension 50104 ItemCard extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shelf No.")
        {
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