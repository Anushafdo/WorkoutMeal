tableextension 50207 Item extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50100; "Shelf Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}