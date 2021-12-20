pageextension 50165 ItemJournal extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Unit Cost")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Unit Amount")
        {
            Visible = false;
        }
        modify("Discount Amount")
        {
            Visible = false;
        }
        modify("Applies-to Entry")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        addafter(Description)
        {
            field(Inventory; Inv)
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        modify("Item No.")
        {
            trigger onaftervalidate()
            var
                myInt: Integer;
                Item: Record Item;
                ILE: Record "Item Ledger Entry";
            begin
                Inv := 0;
                if Item.Get("Item No.") then begin
                    Item.CalcFields(Inventory);
                    Inv := Item.Inventory;
                end;
                ILE.Reset();
                ILE.SetRange("Item No.", "Item No.");
                ILE.SetRange("Variant Code", "Variant Code");
                if ILE.FindSet() then begin
                    ILE.CalcSums(Quantity);
                    Inv := ILE.Quantity;
                end;
            end;
        }
        modify("Variant Code")
        {
            trigger onaftervalidate()
            var
                myInt: Integer;
                Item: Record Item;
                ILE: Record "Item Ledger Entry";
            begin
                Inv := 0;
                if Item.Get("Item No.") then begin
                    Item.CalcFields(Inventory);
                    Inv := Item.Inventory;
                end;
                ILE.Reset();
                ILE.SetRange("Item No.", "Item No.");
                ILE.SetRange("Variant Code", "Variant Code");
                if ILE.FindSet() then begin
                    ILE.CalcSums(Quantity);
                    Inv := ILE.Quantity;
                end;
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger onbeforeaction()
            var
                ItemJnl: Record "Item Journal Line";
            begin
                ItemJnl.Reset();
                ItemJnl.CopyFilters(Rec);
                if ItemJnl.FindFirst() then
                    repeat
                        if NOT ((ItemJnl."Entry Type" = ItemJnl."Entry Type"::"Negative Adjmt.") OR (ItemJnl."Entry Type" = ItemJnl."Entry Type"::"Positive Adjmt.")) then
                            Error('Entry Type must be equal to Negative Adjmt. or Positive Adjmt. for Item No. %1', ItemJnl."Item No.");
                        if ItemJnl."Variant Code" = '' then
                            Error('Variant Code must have a value for Item No. %1', ItemJnl."Item No.");
                    until ItemJnl.Next() = 0;
            end;
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
    begin
        Inv := 0;
        if Item.Get("Item No.") then begin
            Item.CalcFields(Inventory);
            Inv := Item.Inventory;
        end;
        ILE.Reset();
        ILE.SetRange("Item No.", "Item No.");
        ILE.SetRange("Variant Code", "Variant Code");
        if ILE.FindSet() then begin
            ILE.CalcSums(Quantity);
            Inv := ILE.Quantity;
        end;
    end;

    trigger onaftergetrecord()
    var
        myInt: Integer;
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
    begin
        Inv := 0;
        if Item.Get("Item No.") then begin
            Item.CalcFields(Inventory);
            Inv := Item.Inventory;
        end;
        ILE.Reset();
        ILE.SetRange("Item No.", "Item No.");
        ILE.SetRange("Variant Code", "Variant Code");
        if ILE.FindSet() then begin
            ILE.CalcSums(Quantity);
            Inv := ILE.Quantity;
        end;
    end;

    var
        Inv: Integer;
}