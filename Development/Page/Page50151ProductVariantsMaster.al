page 50151 "Product Variants Master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Product Variants Master";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ProductAPIId; ProductAPIId)
                {
                    ApplicationArea = All;
                }
                field(VariantAPIId; VariantAPIId)
                {
                    ApplicationArea = all;
                }
                field(Barcode; Barcode)
                {
                    ApplicationArea = all;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;
                }
                field(Title; Title)
                {
                    ApplicationArea = All;
                }
                field(Price; Price)
                {
                    ApplicationArea = All;
                }
                field(Ingredients; Ingredients)
                {
                    ApplicationArea = All;
                }
                field(TotalWeight; TotalWeight)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Ingredients Master")
            {
                Caption = 'Ingredients Master';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = List;
                RunObject = page "Ingredient Master";
                RunPageLink = Product_API_Id = field(ProductAPIId), Variant_API_Id = field(VariantAPIId);
            }
        }
    }
}