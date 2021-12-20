page 50152 "Customer master"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Customer Master";
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
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field(WasUpdated; WasUpdated)
                {
                    ApplicationArea = all;
                }
                field(Updated; Updated)
                {
                    ApplicationArea = all;
                }
                field(FirstName; FirstName)
                {
                    ApplicationArea = All;
                }
                field(LastName; LastName)
                {
                    ApplicationArea = All;
                }
                field(Tags; Tags)
                {
                    ApplicationArea = All;
                }
                field(Email; Email)
                {
                    ApplicationArea = All;
                }
                field(PhoneNo; PhoneNo)
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(country_name; country_name)
                {
                    ApplicationArea = All;
                }
                field(default; default)
                {
                    ApplicationArea = All;
                }
                field(country; country)
                {
                    ApplicationArea = All;
                }
                field(province; province)
                {
                    ApplicationArea = All;
                }
                field(country_code; country_code)
                {
                    ApplicationArea = All;
                }
                field(province_code; province_code)
                {
                    ApplicationArea = All;
                }
                field(Phone; Phone)
                {
                    ApplicationArea = All;
                }
                field(first_name; first_name)
                {
                    ApplicationArea = All;
                }
                field(Last_name; Last_name)
                {
                    ApplicationArea = All;
                }
                field(Company; Company)
                {
                    ApplicationArea = All;
                }
                field(Add1; Add1)
                {
                    ApplicationArea = All;
                }
                field(Add2; Add2)
                {
                    ApplicationArea = All;
                }
                field(Zip; Zip)
                {
                    ApplicationArea = All;
                }
                field(City; City)
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
                    KitchenWare.GetCustomerAPIData();
                end;
            }
            action("Make Customer")
            {
                Caption = 'Make Customer';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                Image = Item;
                trigger onaction()
                var
                    ConvertKW_API_to_BC: Codeunit ConvertKW_API_to_BC;
                begin
                    ConvertKW_API_to_BC.CreateCustForWorksheet;
                end;
            }
            /*   action("PostAPI")
               {
                   Caption = 'Post API';
                   Promoted = true;
                   PromotedCategory = Process;
                   PromotedIsBig = true;
                   ApplicationArea = All;
                   Image = Item;
                   trigger onaction()
                   var
                       KitchenWare: Codeunit "Kitchenware APIS";
                   begin
                       KitchenWare.TestRestAPI2(APIID, 'customer');
                   end;
               }*/
        }
    }

}