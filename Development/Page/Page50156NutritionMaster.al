page 50156 "Nutritions Master"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Nutritions Master";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ProductId; Product_API_Id)
                {
                    ApplicationArea = All;

                }
                field(VarientId; Variant_API_Id)
                {
                    ApplicationArea = All;

                }
                field(Title; Title)
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field(Weight; Weight)
                {
                    ApplicationArea = All;

                }
                field(UOM; UOM)
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

    var
        myInt: Integer;
}