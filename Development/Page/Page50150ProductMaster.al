page 50150 "Product master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Product Master";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(APIId; APIId)
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(WasUpdated; WasUpdated)
                {
                    ApplicationArea = all;
                }
                field(Title; Title)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(Tags; Tags)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
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
            action("KitchenWare API")
            {
                Caption = 'KitchenWare API';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Email;
                trigger onaction()
                var
                    KitchenWare: Codeunit "Kitchenware APIS";
                begin
                    KitchenWare.GetProductAPIData();
                end;
            }
            action("Product Variant Master")
            {
                Caption = 'Product Variant Master';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Email;
                RunObject = page "Product Variants Master";
                RunPageLink = ProductAPIId = field(APIId);
            }
            action("Make Item")
            {
                Caption = 'Make Item';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Item;
                trigger onaction()
                var
                    ConvertKW_API_to_BC: Codeunit ConvertKW_API_to_BC;
                begin
                    ConvertKW_API_to_BC.CreateItemForWorksheet;
                end;
            }
        }
    }

}