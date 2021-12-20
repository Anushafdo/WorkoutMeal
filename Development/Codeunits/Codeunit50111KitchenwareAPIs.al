codeunit 50111 "Kitchenware APIS"
{
    trigger OnRun();
    begin
        GetProductAPIData();
        GetCustomerAPIData();
        GetSOHeaderAPIData();
    end;

    var

    procedure UpdateBarcode(API_Id: Text[100]);
    var
        Url: Text;
        JToken: JsonToken;
        JObject: JsonObject;
        JValue: JsonValue;
        JArrey: JsonArray;
        JToken2: JsonToken;
        JObject2: JsonObject;
        JValue2: JsonValue;
        JArrey2: JsonArray;
        JArrey3: JsonArray;
        JToken3: JsonToken;
        JText: Text;
        i: Integer;
        Created: Date;
        JTextBar: Text;
        JObjectCreate: JsonObject;
        p: Integer;
        SOHeader: Record "SO Header";
        SaleHeader: Record "Sales Header";
    begin

        Url := 'https://wm.mykitchencentre.com/wiise/orders?shop=workoutmeals.myshopify.com&&apiId=' + API_Id;
        JObject := GetJsonObject(Url);
        JObject.Get('orders', JToken);
        JArrey := JToken.AsArray();
        JArrey.Get(0, JToken);
        JObject := JToken.AsObject();
        if not JObject.Get('apiId', JToken) then
            Error('Could not find token with key: %1');

        IF JObject.Get('barcodes', JToken2) then begin
            JArrey3 := JToken2.AsArray();
            if JArrey3.Get(0, JToken3) then
                JTextBar := JToken3.AsValue().AsText()
        end;
        IF JObject.Get('createdAt', JToken2) then
            JObjectCreate := JToken2.AsObject();



        SOHeader.Reset();
        SOHeader.SetFilter(APIId, GetJsonToken(JObject, 'apiId').AsValue().AsText());
        if SOHeader.FindFirst() then begin
            SOHeader.Barcode := JTextBar;
            SOHeader.CreatedDate := GetDateFromText(GetJsonToken(JObjectCreate, 'date').AsValue().AsText());
            ;
            SOHeader.Modify();
        end;
        Saleheader.Reset();
        Saleheader.SetRange("Document Type", Saleheader."Document Type"::Order);
        Saleheader.SetRange("No.", SOHeader.APIID);
        if Saleheader.FindFirst() then begin
            SaleHeader.Barcode := SOHeader.Barcode;
            SaleHeader.Modify();
        end;

    end;

    procedure TestRestAPI2(API: Text[100]; Type: Text[20]) Responsetext: Text

    var
        client: HttpClient;
        RequestURL: text;
        payload: Text;
        request: HttpRequestMessage;
        response: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        content: HttpContent;

    begin
        payload := '{"shop":"workoutmeals.myshopify.com","entity":"' + Type + '","apiIds":["' + API + '"]}';
        RequestURL := 'https://wm.mykitchencentre.com/wiise/downloaded';
        AddHttpBasicAuthHeader('wiise', 'NbbagddqnSm0npxU9VyG', Client);
        content.WriteFrom(payload);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        contentHeaders.Add('Content-Type', 'application/json');
        //contentHeaders.Add('Cookie', '__cfduid=d3ce3d69d102fa1863eb91727739028f91609562988');
        request.Content := content;
        request.SetRequestUri(RequestURL);
        request.Method := 'POST';
        client.Send(request, response);
        response.Content().ReadAs(responseText);
        //Message(Responsetext);
        exit(ResponseText);
    end;


    procedure OneByOneGetSOHeaderAPIDataByAPIid(API_Id: Text[100]);
    var
        Url: Text;
        JToken: JsonToken;
        JObject: JsonObject;
        JValue: JsonValue;
        JArrey: JsonArray;
        JToken2: JsonToken;
        JObject2: JsonObject;
        JValue2: JsonValue;
        JArrey2: JsonArray;
        JArrey3: JsonArray;
        JToken3: JsonToken;
        JText: Text;
        JTextBar: Text;
        i: Integer;
        x: Integer;
        W: Dialog;
        Tot: Integer;
        JObjectshipAdd: JsonObject;
        JObjectBillAdd: JsonObject;
        JObjectCust: JsonObject;

        JObjectDeldate: JsonObject;
        JObjectPickDate: JsonObject;
        JObjectlineItems: JsonObject;
        JObjecttax_lines: JsonObject;
        JObjectproperties: JsonObject;
        JObjectCreate: JsonObject;
        totalpage: Integer;
        p: Integer;
    begin

        Url := 'https://wm.mykitchencentre.com/wiise/orders?shop=workoutmeals.myshopify.com&&apiId=' + API_Id;
        JObject := GetJsonObject(Url);
        JObject.Get('orders', JToken);
        JArrey := JToken.AsArray();
        JArrey.Get(0, JToken);
        JObject := JToken.AsObject();
        if not JObject.Get('apiId', JToken) then
            Error('Could not find token with key: %1');

        IF JObject.Get('shippingAddress', JToken2) then
            if JToken2.IsObject then
                JObjectshipAdd := JToken2.AsObject();

        IF JObject.Get('customer', JToken2) then
            if JToken2.IsObject then
                JObjectCust := JToken2.AsObject();

        IF JObject.Get('deliveryDate', JToken2) then
            if JToken2.IsObject then
                JObjectDeldate := JToken2.AsObject();
        IF JObject.Get('pickPackDate', JToken2) then
            if JToken2.IsObject then
                JObjectPickDate := JToken2.AsObject();

        IF JObject.Get('barcodes', JToken2) then begin
            JArrey3 := JToken2.AsArray();
            if JArrey3.Get(0, JToken3) then
                JTextBar := JToken3.AsValue().AsText()
        end;
        IF JObject.Get('createdAt', JToken2) then
            if JToken2.IsObject then
                JObjectCreate := JToken2.AsObject();

        InsertSOHeaderAPIData(JObject, JObjectshipAdd, JObjectCust, JObjectDeldate, JObjectPickDate, JTextBar, JObjectCreate);
        JObject.Get('lineItems', JToken2);
        JArrey2 := JToken2.AsArray();
        for x := 0 to JArrey2.Count - 1 do begin
            JArrey2.Get(x, JToken2);
            JObjectlineItems := JToken2.AsObject();

            IF JObjectlineItems.Get('tax_lines', JToken2) then begin
                JArrey3 := JToken2.AsArray();
                if JArrey3.Get(0, JToken3) then
                    JObjecttax_lines := JToken3.AsObject();
            end;

            IF JObjectlineItems.Get('properties', JToken2) then begin
                JArrey3 := JToken2.AsArray();
                if JArrey3.Get(0, JToken3) then
                    JObjectproperties := JToken3.AsObject();
            end;
            InsertSOLineAPIData(JObject, JObjectlineItems, JObjecttax_lines, JObjectproperties);
        end;
    end;

    procedure GetSOHeaderAPIData();
    var
        Url: Text;
        JToken: JsonToken;
        JObject: JsonObject;
        JValue: JsonValue;
        JArrey: JsonArray;
        JToken2: JsonToken;
        JObject2: JsonObject;
        JValue2: JsonValue;
        JArrey2: JsonArray;
        JArrey3: JsonArray;
        JToken3: JsonToken;
        JText: Text;
        JTextBar: Text;
        i: Integer;
        x: Integer;
        W: Dialog;
        Tot: Integer;
        JObjectshipAdd: JsonObject;
        JObjectBillAdd: JsonObject;
        JObjectDeldate: JsonObject;
        JObjectPickDate: JsonObject;
        JObjectCust: JsonObject;
        JObjectBar: JsonObject;
        JObjectlineItems: JsonObject;
        JObjecttax_lines: JsonObject;
        JObjectproperties: JsonObject;
        JObjectCreate: JsonObject;
        totalpage: Integer;
        p: Integer;
    begin
        Url := 'https://wm.mykitchencentre.com/wiise/orders?shop=workoutmeals.myshopify.com&page=1';
        W.Open('Line Insert #1#####\ Page Insert #2#####\ @3@@@@@@@@@@@@@@@@@@@@');
        totalpage := GetTotalPages(Url);
        // totalpage := 72;
        for p := 1 to totalpage do begin
            Url := 'https://wm.mykitchencentre.com/wiise/orders?shop=workoutmeals.myshopify.com&page=' + Format(x);
            JObject := GetJsonObject(Url);
            JObject.Get('orders', JToken);
            JArrey := JToken.AsArray();
            Tot := JArrey.Count;
            for i := 0 to JArrey.Count - 1 do begin
                JArrey.Get(i, JToken);
                JObject := JToken.AsObject();
                if not JObject.Get('apiId', JToken) then
                    Error('Could not find token with key: %1');

                IF JObject.Get('shippingAddress', JToken2) then
                    if JToken2.IsObject then
                        JObjectshipAdd := JToken2.AsObject();
                IF JObject.Get('customer', JToken2) then
                    if JToken2.IsObject then
                        JObjectCust := JToken2.AsObject();

                IF JObject.Get('deliveryDate', JToken2) then
                    if JToken2.IsObject then
                        JObjectDeldate := JToken2.AsObject();
                IF JObject.Get('pickPackDate', JToken2) then
                    if JToken2.IsObject then
                        JObjectPickDate := JToken2.AsObject();

                IF JObject.Get('barcodes', JToken2) then begin
                    JArrey3 := JToken2.AsArray();
                    if JArrey3.Get(0, JToken3) then
                        JTextBar := JToken3.AsValue().AsText();
                end;
                IF JObject.Get('createdAt', JToken2) then
                    if JToken2.IsObject then
                        JObjectCreate := JToken2.AsObject();


                InsertSOHeaderAPIData(JObject, JObjectshipAdd, JObjectCust, JObjectDeldate, JObjectPickDate, JTextBar, JObjectCreate);

                JObject.Get('lineItems', JToken2);
                JArrey2 := JToken2.AsArray();
                for x := 0 to JArrey2.Count - 1 do begin
                    JArrey2.Get(x, JToken2);
                    JObjectlineItems := JToken2.AsObject();

                    IF JObjectlineItems.Get('tax_lines', JToken2) then begin
                        JArrey3 := JToken2.AsArray();
                        if JArrey3.Get(0, JToken3) then
                            JObjecttax_lines := JToken3.AsObject();
                    end;

                    IF JObjectlineItems.Get('properties', JToken2) then begin
                        JArrey3 := JToken2.AsArray();
                        if JArrey3.Get(0, JToken3) then
                            JObjectproperties := JToken3.AsObject();
                    end;
                    InsertSOLineAPIData(JObject, JObjectlineItems, JObjecttax_lines, JObjectproperties);
                end;

                W.Update(1, format(i) + ' out of ' + Format(Tot));
                W.Update(2, format(p) + ' out of ' + Format(totalpage));
                W.Update(3, ROUND(p / totalpage * 10000, 1));
            end;
        end;
        W.Close();
        Message('Orders inserted.');
    end;

    local procedure InsertSOHeaderAPIData(JObject: JsonObject; JObjectShip: JsonObject; JObjectCust: JsonObject; JObjectDelDate: JsonObject; JObjectPPDate: JsonObject; JTextBar: Text; JObjectCreate: JsonObject)
    var
        SOHeader: Record "SO Header";
    begin
        GlobalAPI := GetJsonToken(JObject, 'apiId').AsValue().AsText();
        SOHeader.Reset();
        SOHeader.SetFilter(APIId, GetJsonToken(JObject, 'apiId').AsValue().AsText());
        if not SOHeader.FindFirst() then begin
            SOHeader.Init();
            SOHeader.APIId := GetJsonToken(JObject, 'apiId').AsValue().AsText();
            SOHeader.Insert();
        end;
        Commit();
        SOHeader.Reset();
        SOHeader.SetFilter(APIId, GetJsonToken(JObject, 'apiId').AsValue().AsText());
        if SOHeader.FindFirst() then begin
            if CheckJObjectValue(JObject, 'name') then begin
                SOHeader.name := GetJsonToken(JObject, 'name').AsValue().AsText();
                SOHeader.CutomerAPIid := GetJsonToken(JObject, 'customerApiId').AsValue().AsText();
                SOHeader.Note := CopyStr(GetJsonToken(JObject, 'note').AsValue().AsText(), 1, 500);
                SOHeader.financialStatus := GetJsonToken(JObject, 'financialStatus').AsValue().AsText();
                SOHeader.subtotalPrice := GetJsonToken(JObject, 'subtotalPrice').AsValue().AsDecimal();
                SOHeader.totalDiscounts := GetJsonToken(JObject, 'totalDiscounts').AsValue().AsDecimal();
                SOHeader.totalTax := GetJsonToken(JObject, 'totalTax').AsValue().AsDecimal();
                SOHeader.totalPrice := GetJsonToken(JObject, 'totalPrice').AsValue().AsDecimal();
                SOHeader.location := GetJsonToken(JObject, 'location').AsValue().AsText();
                SOHeader.deliveryHours := GetJsonToken(JObject, 'deliveryHours').AsValue().AsText();
                SOHeader.isSameDayDelivery := GetJsonToken(JObject, 'isSameDayDelivery').AsValue().AsText();
                SOHeader.WasUpdated := GetJsonToken(JObject, 'wasUpdated').AsValue().AsText();
            end;
            if CheckJObjectValue(JObjectShip, 'name') then begin
                SOHeader.name_Ship := GetJsonToken(JObjectShip, 'name').AsValue().AsText();
                SOHeader.latitude_Ship := GetJsonToken(JObjectShip, 'latitude').AsValue().AsText();
                SOHeader.longitude_Ship := GetJsonToken(JObjectShip, 'longitude').AsValue().AsText();
                SOHeader.country_Ship := GetJsonToken(JObjectShip, 'country').AsValue().AsText();
                SOHeader.province_Ship := GetJsonToken(JObjectShip, 'province').AsValue().AsText();
                SOHeader.country_code_Ship := GetJsonToken(JObjectShip, 'country_code').AsValue().AsText();
                SOHeader.province_code_Ship := GetJsonToken(JObjectShip, 'province_code').AsValue().AsText();
                SOHeader.phone_Ship := GetJsonToken(JObjectShip, 'phone').AsValue().AsText();
                SOHeader.first_name_Ship := GetJsonToken(JObjectShip, 'first_name').AsValue().AsText();
                SOHeader.last_name_Ship := GetJsonToken(JObjectShip, 'last_name').AsValue().AsText();
                SOHeader.company_Ship := GetJsonToken(JObjectShip, 'company').AsValue().AsText();
                SOHeader.address1_Ship := GetJsonToken(JObjectShip, 'address1').AsValue().AsText();
                SOHeader.address2_Ship := GetJsonToken(JObjectShip, 'address2').AsValue().AsText();
                //SOHeader.zip_Ship := GetJsonToken(JObjectShip, 'zip').AsValue().AsText();
                //SOHeader.city_Ship := GetJsonToken(JObjectShip, 'city').AsValue().AsText();
            end;
            if CheckJObjectValue(JObjectCust, 'id') then begin
                SOHeader.id_Cust := GetJsonToken(JObjectCust, 'id').AsValue().AsText();
                SOHeader.email_Cust := GetJsonToken(JObjectCust, 'email').AsValue().AsText();
                SOHeader.created_at_Cust := GetJsonToken(JObjectCust, 'created_at').AsValue().AsText();
                SOHeader.updated_at_Cust := GetJsonToken(JObjectCust, 'updated_at').AsValue().AsText();
                SOHeader.accepts_marketing_Cust := GetJsonToken(JObjectCust, 'accepts_marketing').AsValue().AsText();
                SOHeader.first_name_Cust := GetJsonToken(JObjectCust, 'first_name').AsValue().AsText();
                SOHeader.last_name_Cust := GetJsonToken(JObjectCust, 'last_name').AsValue().AsText();
                SOHeader.orders_count_Cust := GetJsonToken(JObjectCust, 'orders_count').AsValue().AsText();
                SOHeader.state_Cust := GetJsonToken(JObjectCust, 'state').AsValue().AsText();
                SOHeader.total_spent_Cust := GetJsonToken(JObjectCust, 'total_spent').AsValue().AsText();
                SOHeader.note_Cust := GetJsonToken(JObjectCust, 'note').AsValue().AsText();
                SOHeader.phone_Cust := GetJsonToken(JObjectCust, 'phone').AsValue().AsText();
                SOHeader.tags_Cust := GetJsonToken(JObjectCust, 'tags').AsValue().AsText();
            end;
            if CheckJObjectValue(JObjectDelDate, 'date') then
                SOHeader.DeliveryDate := GetDateFromText(GetJsonToken(JObjectDelDate, 'date').AsValue().AsText());
            if CheckJObjectValue(JObjectPPDate, 'date') then
                SOHeader.PickPackDate := GetDateFromText(GetJsonToken(JObjectPPDate, 'date').AsValue().AsText());
            SOHeader.Barcode := JTextBar;
            SOHeader.CreatedDate := GetDateFromText(GetJsonToken(JObjectCreate, 'date').AsValue().AsText());
            SOHeader.Updated := true;
            SOHeader.Modify();
        end;
    end;

    local procedure InsertSOLineAPIData(JObject: JsonObject; JObjectLine: JsonObject; JObjecttax: JsonObject; JObjectProp: JsonObject)
    var
        SOLine: Record "SO Line";
    begin
        SOLine.Reset();
        SOLine.SetFilter(APIid, GetJsonToken(JObject, 'apiId').AsValue().AsText());
        SOLine.SetFilter(id, GetJsonToken(JObjectLine, 'id').AsValue().AsText());
        if SOLine.FindFirst() then
            SOLine.DeleteAll();

        SOLine.Reset();
        SOLine.SetFilter(APIid, GetJsonToken(JObject, 'apiId').AsValue().AsText());
        SOLine.SetFilter(id, GetJsonToken(JObjectLine, 'id').AsValue().AsText());
        if not SOLine.FindFirst() then begin
            SOLine.Init();
            SOLine.APIid := GetJsonToken(JObject, 'apiId').AsValue().AsText();
            SOLine.id := GetJsonToken(JObjectLine, 'id').AsValue().AsText();
            SOLine.variant_title := GetJsonToken(JObjectLine, 'variant_title').AsValue().AsText();
            SOLine.fulfillment_service := GetJsonToken(JObjectLine, 'fulfillment_service').AsValue().AsText();
            SOLine.fulfillment_status := GetJsonToken(JObjectLine, 'fulfillment_status').AsValue().AsText();
            SOLine.fulfillable_quantity := GetJsonToken(JObjectLine, 'fulfillable_quantity').AsValue().AsDecimal();
            SOLine.requires_shipping := GetJsonToken(JObjectLine, 'requires_shipping').AsValue().AsText();
            SOLine.taxable := GetJsonToken(JObjectLine, 'taxable').AsValue().AsText();
            SOLine.name := GetJsonToken(JObjectLine, 'name').AsValue().AsText();
            SOLine.variant_id := GetJsonToken(JObjectLine, 'variant_id').AsValue().AsText();
            SOLine.title := GetJsonToken(JObjectLine, 'title').AsValue().AsText();
            SOLine.quantity := GetJsonToken(JObjectLine, 'quantity').AsValue().AsDecimal();
            SOLine.price := GetJsonToken(JObjectLine, 'price').AsValue().AsDecimal();
            SOLine.grams := GetJsonToken(JObjectLine, 'grams').AsValue().AsDecimal();
            SOLine.sku := GetJsonToken(JObjectLine, 'sku').AsValue().AsText();
            SOLine.vendor := GetJsonToken(JObjectLine, 'vendor').AsValue().AsText();
            SOLine.product_id := GetJsonToken(JObjectLine, 'product_id').AsValue().AsText();
            SOLine.gift_card := GetJsonToken(JObjectLine, 'gift_card').AsValue().AsText();
            //SOLine.total_discount := GetJsonToken(JObjectLine, 'total_discount').AsValue().AsDecimal();
            //SOLine.applied_discount := GetJsonToken(JObjectLine, 'applied_discount').AsValue().AsDecimal();
            //    SOLine.price_tax := GetJsonToken(JObjecttax, 'price').AsValue().AsDecimal();
            //  SOLine.rate_tax := GetJsonToken(JObjecttax, 'rate').AsValue().AsDecimal();
            //SOLine.title_tax := GetJsonToken(JObjecttax, 'title').AsValue().AsText();
            //SOLine.name_property := GetJsonToken(JObjectProp, 'name').AsValue().AsText();
            //SOLine.value_Property := GetJsonToken(JObjectProp, 'value').AsValue().AsText();
            SOLine.Insert();
            TestRestAPI2(SOLine.APIID, 'order');
        end;
    end;

    procedure GetCustomerAPIData();
    var
        Url: Text;
        JToken: JsonToken;
        JObject: JsonObject;
        JValue: JsonValue;
        JArrey: JsonArray;
        JToken2: JsonToken;
        JObject2: JsonObject;
        JValue2: JsonValue;
        JArrey2: JsonArray;
        JText: Text;
        i: Integer;
        x: Integer;
        W: Dialog;
        Tot: Integer;
        totalpage: Integer;
    begin
        // Url := 'https://wm-preprod.app-gwa.com/wiise/customers?shop=workout-meals-preprod.myshopify.com';
        Url := 'https://wm.mykitchencentre.com/wiise/customers?shop=workoutmeals.myshopify.com&page=1';
        W.Open('Line Insert #1#####\ Page Insert #2#####\ @3@@@@@@@@@@@@@@@@@@@@');
        totalpage := GetTotalPages(Url);
        // totalpage := 72;
        for x := 1 to totalpage do begin
            Url := 'https://wm.mykitchencentre.com/wiise/customers?shop=workoutmeals.myshopify.com&page=' + Format(x);
            JObject := GetJsonObject(Url);
            JObject.Get('customers', JToken);
            JArrey := JToken.AsArray();
            Tot := JArrey.Count;
            for i := 0 to JArrey.Count - 1 do begin
                JArrey.Get(i, JToken);
                JObject := JToken.AsObject();
                if not JObject.Get('apiId', JToken) then
                    Error('Could not find token with key: %1');

                IF JObject.Get('defaultAddress', JToken2) then
                    JObject2 := JToken2.AsObject();
                InsertCustomerAPIData(JObject, JObject2, JArrey2);
                W.Update(1, format(i) + ' out of ' + Format(Tot));
                W.Update(2, format(x) + ' out of ' + Format(totalpage));
                W.Update(3, ROUND(x / totalpage * 10000, 1));
            end;
        end;
        W.Close();
        Message('Customer Master inserted.');
    end;

    local procedure InsertCustomerAPIData(JObject: JsonObject; JObject2: JsonObject; JArrey2: JsonArray)
    var
        CustomerMaster: Record "Customer Master";
        js: JsonValue;
    begin

        CustomerMaster.Reset();
        CustomerMaster.SetFilter(APIId, GetJsonToken(JObject, 'apiId').AsValue().AsText());
        if not CustomerMaster.FindFirst() then begin
            CustomerMaster.Init();
            CustomerMaster.APIId := GetJsonToken(JObject, 'apiId').AsValue().AsText();
            CustomerMaster.Insert();
        end;

        CustomerMaster.Reset();
        CustomerMaster.SetFilter(APIId, GetJsonToken(JObject, 'apiId').AsValue().AsText());
        if CustomerMaster.FindFirst() then begin
            CustomerMaster.FirstName := GetJsonToken(JObject, 'firstName').AsValue().AsText();
            CustomerMaster.LastName := GetJsonToken(JObject, 'lastName').AsValue().AsText();
            CustomerMaster.Email := GetJsonToken(JObject, 'email').AsValue().AsText();
            CustomerMaster.Tags := GetJsonToken(JObject, 'tags').AsValue().AsText();
            CustomerMaster.PhoneNo := GetJsonToken(JObject, 'phone').AsValue().AsText();
            CustomerMaster.WasUpdated := GetJsonToken(JObject, 'wasUpdated').AsValue().AsText();
            CustomerMaster.Name := GetJsonToken(JObject2, 'name').AsValue().AsText();
            CustomerMaster.country_name := GetJsonToken(JObject2, 'country_name').AsValue().AsText();
            CustomerMaster.default := GetJsonToken(JObject2, 'default').AsValue().AsText();
            CustomerMaster.country := GetJsonToken(JObject2, 'country').AsValue().AsText();
            CustomerMaster.province := GetJsonToken(JObject2, 'province').AsValue().AsText();
            CustomerMaster.country_code := GetJsonToken(JObject2, 'country_code').AsValue().AsText();
            CustomerMaster.province_code := GetJsonToken(JObject2, 'province_code').AsValue().AsText();
            CustomerMaster.Phone := GetJsonToken(JObject2, 'phone').AsValue().AsText();
            CustomerMaster.first_name := GetJsonToken(JObject2, 'first_name').AsValue().AsText();
            CustomerMaster.Last_name := GetJsonToken(JObject2, 'last_name').AsValue().AsText();
            CustomerMaster.Company := GetJsonToken(JObject2, 'company').AsValue().AsText();
            CustomerMaster.Add1 := GetJsonToken(JObject2, 'address1').AsValue().AsText();
            CustomerMaster.Add2 := GetJsonToken(JObject2, 'address2').AsValue().AsText();
            CustomerMaster.Zip := GetJsonToken(JObject2, 'zip').AsValue().AsText();
            CustomerMaster.City := GetJsonToken(JObject2, 'city').AsValue().AsText();
            CustomerMaster.Updated := true;
            CustomerMaster.Modify();
            TestRestAPI2(CustomerMaster.APIID, 'customer');
        end;

    end;

    procedure GetProductAPIData();
    var
        JToken: JsonToken;
        JObject: JsonObject;
        JValue: JsonValue;
        JArrey: JsonArray;
        JToken2: JsonToken;
        JObject2: JsonObject;
        JValue2: JsonValue;
        JArrey2: JsonArray;
        JToken3: JsonToken;
        JObject3: JsonObject;
        JValue3: JsonValue;
        JArrey3: JsonArray;
        Url: text;
        Tot: Integer;
        Tot2: Integer;
        i: Integer;
        x: Integer;
        k: Integer;
        W: Dialog;
        Tags: Text[500];
        Ingredient: Text[1024];
        ProAPI: Text[100];
    begin
        //Url := 'https://wm-preprod.app-gwa.com/wiise/products?shop=workout-meals-preprod.myshopify.com';
        Url := 'https://wm.mykitchencentre.com/wiise/products?shop=workoutmeals.myshopify.com';
        JObject := GetJsonObject(Url);
        //ProdVarMaster.DeleteAll();
        W.Open('Line Insert #1#####\ @2@@@@@@@@@@@@@@@@@@@@');

        JObject.Get('products', JToken);
        JArrey := JToken.AsArray();
        Tot := JArrey.Count;
        for i := 0 to JArrey.Count - 1 do begin
            JArrey.Get(i, JToken);
            JObject := JToken.AsObject();
            if not JObject.Get('apiId', JToken) then
                Error('Could not find token with key: %1');
            ProAPI := GetJsonToken(JObject, 'apiId').AsValue().AsText();

            Clear(Tags);
            IF JObject.Get('tags', JToken2) then begin
                JArrey2 := JToken2.AsArray();
                Tot2 := JArrey2.Count;
                for x := 0 to JArrey2.Count - 1 do begin
                    JArrey2.Get(x, JToken2);
                    if Tags <> '' then
                        Tags := Tags + ', ' + JToken2.AsValue().AsText()
                    else
                        Tags := JToken2.AsValue().AsText();
                end;
            end;

            InsertProductAPIData(ProAPI,
            GetJsonToken(JObject, 'title').AsValue().AsText(),
            GetJsonToken(JObject, 'type').AsValue().AsText(),
            Tags,
            GetJsonToken(JObject, 'description').AsValue().AsText()
            );

            IF JObject.Get('variants', JToken2) then begin
                JArrey2 := JToken2.AsArray();
                for x := 0 to JArrey2.Count - 1 do begin
                    JArrey2.Get(x, JToken2);
                    JObject2 := JToken2.AsObject();
                    if not JObject2.Get('apiId', JToken2) then
                        Error('Could not find token with key: %1');

                    Clear(Ingredient);
                    IF JObject2.Get('ingredients', JToken3) then begin
                        JArrey3 := JToken3.AsArray();
                        for k := 0 to JArrey3.Count - 1 do begin
                            JArrey3.Get(k, JToken3);
                            if Ingredient <> '' then
                                Ingredient := Ingredient + ', ' + JToken3.AsValue().AsText()
                            else
                                Ingredient := JToken3.AsValue().AsText();
                        end;
                    end;

                    InsertProductVariantAPIData(ProAPI,
                    GetJsonToken(JObject2, 'apiId').AsValue().AsText(),
                    GetJsonToken(JObject2, 'title').AsValue().AsText(),
                    GetJsonToken(JObject2, 'price').AsValue().AsText(),
                    Ingredient,
                    GetJsonToken(JObject2, 'totalWeight').AsValue().AsText()
                    );
                end;
            end;

            W.Update(1, format(i + 1) + ' out of ' + Format(Tot));
            W.Update(2, ROUND(i / Tot * 10000, 1));
        end;
        GetIngrediantAPIData;
        W.Close();
        Message('Product Master inserted.');
    end;

    local procedure InsertProductAPIData(APIId: Text[100]; title: Text[500]; Type1: Text[100]; tags: Text[500]; Desc: Text[2048])
    var
        ProductMaster: Record "Product Master";
    begin

        ProductMaster.Reset();
        ProductMaster.SetFilter(APIId, APIId);
        if not ProductMaster.FindFirst() then begin
            ProductMaster.Init();
            ProductMaster.APIId := APIId;
            ProductMaster.Insert();
        end;
        ProductMaster.Reset();
        ProductMaster.SetFilter(APIId, APIId);
        if ProductMaster.FindFirst() then begin
            ProductMaster.APIId := APIId;
            ProductMaster.Title := title;
            ProductMaster.Type := Type1;
            ProductMaster.Description := Desc;
            ProductMaster.Tags := tags;
            ProductMaster.Modify();
        end;
    end;

    procedure GetIngrediantAPIData();
    var
        JToken: JsonToken;
        JObject: JsonObject;
        JValue: JsonValue;
        JArrey: JsonArray;
        JToken2: JsonToken;
        JObject2: JsonObject;
        JValue2: JsonValue;
        JArrey2: JsonArray;
        JToken3: JsonToken;
        JObject3: JsonObject;
        JValue3: JsonValue;
        JArrey3: JsonArray;
        Url: text;
        Tot: Integer;
        Tot2: Integer;
        i: Integer;
        x: Integer;
        k: Integer;
        W: Dialog;
        ProAPI: Text[100];
        VarAPI: Text[100];
    begin
        Url := 'https://wm.mykitchencentre.com/wiise/ingredients?shop=workoutmeals.myshopify.com';
        JObject := GetJsonObject(Url);

        NutrittnMaster.DeleteAll();
        IngrdMaster.DeleteAll();

        JObject.Get('variants', JToken);
        JArrey := JToken.AsArray();
        Tot := JArrey.Count;
        for i := 0 to JArrey.Count - 1 do begin
            JArrey.Get(i, JToken);
            JObject := JToken.AsObject();
            if not JObject.Get('productApiId', JToken) then
                Error('Could not find token with key: %1');

            IF JObject.Get('ingredientsData', JToken2) then begin
                JArrey2 := JToken2.AsArray();
                for x := 0 to JArrey2.Count - 1 do begin
                    JArrey2.Get(x, JToken2);
                    JObject2 := JToken2.AsObject();
                    InsertIngredientsDataAPIData(JObject, JObject2);

                    IF JObject2.Get('nutrition', JToken3) then begin
                        JArrey3 := JToken3.AsArray();
                        for k := 0 to JArrey3.Count - 1 do begin
                            JArrey3.Get(k, JToken3);
                            JObject3 := JToken3.AsObject();
                            InsertNutritionsDataAPIData(JObject, JObject2, JObject3);
                        end;
                    end;
                end;
            end;
        end;
    end;


    local procedure InsertIngredientsDataAPIData(JObject: JsonObject; JObject2: JsonObject)
    var
        IngredientMaster: Record "Ingredient Master";
        Item: Record Item;
        UOM: Record "Unit of Measure";
    begin
        IngredientMaster.Reset();
        IngredientMaster.SetFilter(Product_API_Id, GetJsonToken(JObject, 'productApiId').AsValue().AsText());
        IngredientMaster.SetFilter(Variant_API_Id, GetJsonToken(JObject, 'apiId').AsValue().AsText());
        IngredientMaster.SetFilter(Type, GetJsonToken(JObject2, 'type').AsValue().AsText());
        if not IngredientMaster.FindFirst() then begin
            IngredientMaster.Init();
            IngredientMaster.Product_API_Id := GetJsonToken(JObject, 'productApiId').AsValue().AsText();
            IngredientMaster.Variant_API_Id := GetJsonToken(JObject, 'apiId').AsValue().AsText();
            IngredientMaster.Title := GetJsonToken(JObject2, 'title').AsValue().AsText();
            IngredientMaster.Type := GetJsonToken(JObject2, 'type').AsValue().AsText();
            IngredientMaster.Weight := GetJsonToken(JObject2, 'weight').AsValue().AsDecimal();
            IngredientMaster.UOM := GetJsonToken(JObject2, 'UOM').AsValue().AsText();
            IngredientMaster.Insert();
            if not UOM.Get(IngredientMaster.UOM) then begin
                UOM.Init();
                UOM.validate(Code, IngredientMaster.UOM);
                UOM.Description := IngredientMaster.UOM;
                UOM.Insert();
            end;
            if Item.Get(IngredientMaster.Product_API_Id) then begin
                Item.Validate("Base Unit of Measure", IngredientMaster.UOM);
                Item.Modify();
            end;
        end;
    end;

    local procedure InsertNutritionsDataAPIData(JObject: JsonObject; JObject2: JsonObject; JObject3: JsonObject)
    var
        NutritionsMaster: Record "Nutritions Master";
    begin
        NutritionsMaster.Reset();
        NutritionsMaster.SetFilter(Product_API_Id, GetJsonToken(JObject, 'productApiId').AsValue().AsText());
        NutritionsMaster.SetFilter(Variant_API_Id, GetJsonToken(JObject, 'apiId').AsValue().AsText());
        NutritionsMaster.SetFilter(Title, GetJsonToken(JObject2, 'type').AsValue().AsText());
        NutritionsMaster.SetFilter(Name, GetJsonToken(JObject3, 'name').AsValue().AsText());
        if not NutritionsMaster.FindFirst() then begin
            NutritionsMaster.Init();
            NutritionsMaster.Product_API_Id := GetJsonToken(JObject, 'productApiId').AsValue().AsText();
            NutritionsMaster.Variant_API_Id := GetJsonToken(JObject, 'apiId').AsValue().AsText();
            NutritionsMaster.Title := GetJsonToken(JObject2, 'type').AsValue().AsText();
            NutritionsMaster.Name := GetJsonToken(JObject3, 'name').AsValue().AsText();
            // NutritionsMaster.Weight := GetJsonToken(JObject3, 'weight').AsValue().AsDecimal();
            NutritionsMaster.UOM := GetJsonToken(JObject3, 'UOM').AsValue().AsText();
            NutritionsMaster.Insert();
        end;
    end;

    local procedure InsertProductVariantAPIData(ProAPIId: Text[100]; VarAPIId: Text[100]; title: Text[500]; Price: Text[100]; Ingrd: Text[1024]; Totwgt: Text[100])
    var
        ProductVarMaster: Record "Product Variants Master";
    begin

        ProductVarMaster.Reset();
        ProductVarMaster.SetFilter(ProductAPIId, ProAPIId);
        ProductVarMaster.SetFilter(ProductVarMaster.VariantAPIId, VarAPIId);
        if not ProductVarMaster.FindFirst() then begin
            ProductVarMaster.ProductAPIId := ProAPIId;
            ProductVarMaster.VariantAPIId := VarAPIId;
            ProductVarMaster.Insert();
        end;
        ProductVarMaster.Reset();
        ProductVarMaster.SetFilter(ProductAPIId, ProAPIId);
        ProductVarMaster.SetFilter(ProductVarMaster.VariantAPIId, VarAPIId);
        if ProductVarMaster.FindFirst() then begin
            ProductVarMaster."Item No." := ProAPIId;
            ProductVarMaster.Title := title;
            ProductVarMaster.Price := Price;
            ProductVarMaster.Ingredients := Ingrd;
            ProductVarMaster.TotalWeight := Totwgt;
            ProductVarMaster.Modify();
        end;
    end;

    procedure GetTotalPages(Url: Text): Integer
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        TotalPages: Integer;
        JText: text;
        JObject: JsonObject;
    begin
        AddHttpBasicAuthHeader('wiise', 'NbbagddqnSm0npxU9VyG', Client);
        Client.Get(Url, ResponseMessage);

        If not ResponseMessage.IsSuccessStatusCode() then
            Error('Web service returned error:\\' +
                'Status code: %1\' +
                'Description: %2',
                ResponseMessage.HttpStatusCode(),
                ResponseMessage.ReasonPhrase());
        ResponseMessage.Content().ReadAs(JText);
        //Message(JText);
        if not JObject.ReadFrom(JText) then
            Error('Invalid Response, expected an JSON arrey as root object');
        TotalPages := GetJsonToken(JObject, 'pages').AsValue().AsInteger();
        exit(TotalPages);
    end;

    procedure GetJsonObject(Url: Text) JObject: JsonObject
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        JText: Text;
    begin
        AddHttpBasicAuthHeader('wiise', 'NbbagddqnSm0npxU9VyG', Client);
        Client.Get(Url, ResponseMessage);

        If not ResponseMessage.IsSuccessStatusCode() then
            Error('Web service returned error:\\' +
                'Status code: %1\' +
                'Description: %2',
                ResponseMessage.HttpStatusCode(),
                ResponseMessage.ReasonPhrase());
        ResponseMessage.Content().ReadAs(JText);
        //Message(JText);
        if not JObject.ReadFrom(JText) then
            Error('Invalid Response, expected an JSON arrey as root object');
    end;


    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken
    var
        JText: Text;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find token with key: %1 %2', TokenKey, GlobalAPI);
    end;

    local procedure CheckJObjectValue(JsonObject: JsonObject; TokenKey: text): Boolean;
    var
        JText: Text;
        Jtoken: JsonToken;
    begin
        if JsonObject.Get(TokenKey, Jtoken) then
            exit(true);
        exit(false);
    end;

    local procedure GetDateFromText(DateText: Text): Date
    var
        Year: Integer;
        Month: Integer;
        Day: Integer;
    begin
        if DateText <> '' then begin
            EVALUATE(Year, COPYSTR(DateText, 1, 4));
            EVALUATE(Month, COPYSTR(DateText, 6, 2));
            EVALUATE(Day, COPYSTR(DateText, 9, 2));
            EXIT(DMY2DATE(Day, Month, Year));
        end;
        exit(0D);
    end;

    local procedure AddHttpBasicAuthHeader(UserName: Text[50]; Password: Text[50]; var HttpClient: HttpClient);
    var
        AuthString: Text;
        cc: Codeunit "Base64 Convert";
    begin
        AuthString := STRSUBSTNO('%1:%2', UserName, Password);
        AuthString := cc.ToBase64(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
    end;

    var
        ProMaster: Record "Product Master";
        CustMaster: Record "Customer Master";
        ProdVarMaster: Record "Product Variants Master";
        SOHeaderRec: Record "SO Header";
        SOLineRec: Record "SO Line";
        IngrdMaster: Record "Ingredient Master";
        NutrittnMaster: Record "Nutritions Master";
        GlobalAPI: Text[100];


}