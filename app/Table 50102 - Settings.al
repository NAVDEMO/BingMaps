table 50102 "freddyk BingMaps Settings"
{
    // version BingMaps


    fields
    {
        field(50100; "Primary Key"; Code[10])
        {
        }
        field(50101; "BingMaps Key"; Text[80])
        {

            trigger OnValidate()
            begin
                "BingMaps Key OK" := false;
            end;
        }
        field(50102; "BingMaps Key OK"; Boolean)
        {
        }
        field(50103; "Web Services Username"; Text[40])
        {
        }
        field(50104; "Web Services Key"; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

