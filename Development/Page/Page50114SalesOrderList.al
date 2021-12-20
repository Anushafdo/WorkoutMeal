pageextension 50114 SaleOrderList extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Order No."; "Order No.")
            {
                ApplicationArea = all;
            }
            field("Pick /Pack Date"; "Pick /Pack Date")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Post)
        {
            action("Auto Posting")
            {
                ApplicationArea = all;
                Promoted = true;
                Image = Post;
                RunObject = codeunit "Sales Invoice Posting Process";
            }
        }
    }

    var
        myInt: Integer;
}