page 50154 "SO Line"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SO Line";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(APIid; APIid)
                {
                    ApplicationArea = All;
                }
                field(id; id)
                {
                    ApplicationArea = All;
                }


                field(variant_id; variant_id)
                {
                    ApplicationArea = All;
                }
                field(variant_title; variant_title)
                {
                    ApplicationArea = All;
                }
                field(fulfillable_quantity; fulfillable_quantity)
                {
                    ApplicationArea = All;
                }
                field(name; name)
                {
                    ApplicationArea = All;
                }
                field(price_tax; price_tax)
                {
                    ApplicationArea = All;
                }
                field(rate_tax; rate_tax)
                {
                    ApplicationArea = All;
                }

                field(title_tax; title_tax)
                {
                    ApplicationArea = All;
                }
                field(quantity; quantity)
                {
                    ApplicationArea = All;
                }
                field(price; price)
                {
                    ApplicationArea = All;
                }
                field(pre_tax_price; pre_tax_price)
                {
                    ApplicationArea = All;
                }
                field(grams; grams)
                {
                    ApplicationArea = All;
                }
                field(sku; sku)
                {
                    ApplicationArea = All;
                }
                field(product_id; product_id)
                {
                    ApplicationArea = All;
                }
                field(name_property; name_property)
                {
                    ApplicationArea = All;
                }
                field(value_Property; value_Property)
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}