page 50157 "Kitchen Run Sheet"
{
    Caption = 'Kitchen Run Sheet';
    PageType = list;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "Item Variant";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field("Variant ID"; "Variant ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Total_Order; Total_Order)
                {
                    ApplicationArea = All;

                }

                field(Total_Inventery; Total_Inventery)
                {
                    ApplicationArea = All;

                }
                field(Differance; Differncer)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }

    }
    trigger OnAfterGetRecord()
    begin
        differncer := Total_Inventery - Total_Order;
    end;


    var

        myInt: Integer;
        differncer: Decimal;
}