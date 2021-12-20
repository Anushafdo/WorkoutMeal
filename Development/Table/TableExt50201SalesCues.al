tableextension 50201 "ongoning Delivery" extends "Sales Cue"
{
    fields
    {
        field(50101; "Order to Pick Today"; Integer)
        {
            FieldClass = FlowField;
            //CalcFormula = count("Sales Header" where(IsSameDayDelivery = const(true)));
            CalcFormula = count("Sales Header" where(Status = filter('Open'), "Pick /Pack Date" = field("Pick Date Filter")));
            Editable = false;

        }
        field(50102; "Same Day Delivery AM"; Integer)
        {
            FieldClass = FlowField;
            //  CalcFormula = count("Sales Header" where(IsSameDayDelivery = const(true), "Delivery Hours" = const('AM')));
            CalcFormula = count("Sales Header" where(IsSameDayDelivery = const(true), Status = filter('Open'), "Pick /Pack Date" = field("Pick Date Filter"), "Delivery Hours" = const('AM')));
            Editable = false;
        }
        field(50103; "Same Day Delivery PM"; Integer)
        {
            FieldClass = FlowField;
            // CalcFormula = count("Sales Header" where(IsSameDayDelivery = const(true), "Delivery Hours" = const('PM')));
            CalcFormula = count("Sales Header" where(IsSameDayDelivery = const(true), Status = filter('Open'), "Pick /Pack Date" = field("Pick Date Filter"), "Delivery Hours" = const('Business Hours')));
            Editable = false;
        }
        field(50104; "Pick Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Editable = false;
        }

    }

    var
        myInt: Integer;
}