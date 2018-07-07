tableextension 50100 "freddyk BingMaps Cust Table" extends Customer
{
    fields
    {
        field(50100; Geocoded; Integer)
        {
            DataClassification = EndUserIdentifiableInformation;
        }

        field(50101; Latitude; Decimal)
        {
            DecimalPlaces = 3 : 5;
            DataClassification = EndUserIdentifiableInformation;
        }

        field(50102; Longitude; Decimal)
        {
            DecimalPlaces = 3 : 5;
            DataClassification = EndUserIdentifiableInformation;
        }

        field(50103; Zoom; Integer)
        {
            DataClassification = EndUserIdentifiableInformation;
        }
    }

    keys
    {
        key(Latitude; Latitude)
        {

        }

        key(Longitude; Longitude)
        {
        }
    }

    trigger OnBeforeModify()
    begin
        GeocodeCustomer();
    end;

    trigger OnBeforeInsert()
    begin
        GeocodeCustomer();
    end;

    procedure GeocodeCustomer()
    var
        ErrorText: Text;
    begin
        GeocodeCustomer1(ErrorText);
    end;

    procedure GeocodeCustomer1(var ErrorText: Text): Boolean
    var
        Country: Record "Country/Region";
        Geocode: Codeunit "freddyk BingMaps Geocode";
    begin
        Geocoded := 0;
        if Country.GET("Country/Region Code") then
            if Geocode.Geocode(Address + ' ' + "Address 2" + ' ' + City + ' ' + Country.Name, Latitude, Longitude, ErrorText) then begin
                // Full address geocoded
                Zoom := 15;
                Geocoded := 1;
                exit(true);
            end else
                if Geocode.Geocode(City + ' ' + Country.Name, Latitude, Longitude, ErrorText) then begin
                    // City and country geocoded
                    Zoom := 9;
                    Geocoded := 1;
                    exit(true);
                end else begin
                    // Geocoding not possible
                    Latitude := 0;
                    Longitude := 0;
                    Zoom := 0;
                    Geocoded := -1;
                    exit(false);
                end;
        exit(false);
    end;
}