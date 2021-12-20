page 50155 "Ingredient Master"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Ingredient Master";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(IngredientData)
            {
                field(Product_API_Id; Product_API_Id)
                {
                    ApplicationArea = All;

                }
                field(Variant_API_Id; Variant_API_Id)
                {
                    ApplicationArea = All;

                }
                field(Title; Title)
                {
                    ApplicationArea = All;

                }
                field(Type; Type)
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
            action("Nutrition Master")
            {
                Caption = 'Nutrition Master';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = List;
                RunObject = page "Nutritions Master";
                RunPageLink = Product_API_Id = field(Product_API_Id), Variant_API_Id = field(Variant_API_Id), Title = field(Type);
            }
        }
    }

    var
        myInt: Integer;
}