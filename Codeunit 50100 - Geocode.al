codeunit 50100 "freddyk BingMaps Geocode"
{
    procedure Geocode(Query: Text; var Latitude: Decimal; var Longitude: Decimal; var ErrorText: Text): Boolean
    var
        BingMapsKey: Text;
        Url: Text;
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        Result: Text;
        ResContent: JsonObject;
        EstimatedTotalToken: JsonToken;
        LatitudeToken: JsonToken;
        LongitudeToken: JsonToken;
        BingMapsSettings: Record "freddyk BingMaps Settings";
    begin
        if not BingMapsSettings.FindFirst() then begin
            ErrorText := 'BingMaps Integration not properly setup';
            exit(false);
        end;
        ErrorText := '';
        BingMapsKey := BingMapsSettings."BingMaps Key";
        if BingMapsKey = '' then begin
            ErrorText := 'BingMaps Key not defined';
            exit(false);
        end;
        Url := 'http://dev.virtualearth.net/REST/v1/Locations?q=' + Query + '&o=json&key=' + BingMapsKey;
        Client.Get(Url, ResponseMessage);
        if not ResponseMessage.IsSuccessStatusCode() then begin
            ErrorText := 'Error connecting to Web Service';
            EXIT(false);
        end;
        ResponseMessage.Content().ReadAs(Result);
        if not ResContent.ReadFrom(Result) then begin
            ErrorText := 'Invalid response from Web Service';
            EXIT(false);
        end;
        if not ResContent.SelectToken('resourceSets[0].estimatedTotal', EstimatedTotalToken) then begin
            ErrorText := 'Could not geocode address, estimatedTotal is missing';
            EXIT(false);
        end;
        if EstimatedTotalToken.AsValue().AsInteger() = 0 then begin
            ErrorText := 'Could not geocode address, estimatedTotal is 0';
            EXIT(false);
        end;
        if (not ResContent.SelectToken('resourceSets[0].resources[0].point.coordinates[0]', LatitudeToken)) or
           (not ResContent.SelectToken('resourceSets[0].resources[0].point.coordinates[1]', LongitudeToken)) then begin
            ErrorText := 'Could not geocode address, coordinates is missing';
            EXIT(false);
        end;
        Latitude := LatitudeToken.AsValue().AsDecimal();
        Longitude := LongitudeToken.AsValue().AsDecimal();
        EXIT(true);
    end;

    trigger OnRun();
    var
        Cust: Record Customer;
    begin
        if Cust.FindSet() then
            repeat
                Cust.GeocodeCustomer();
                Cust.Modify();
                Commit();
            until Cust.Next() = 0;
    end;
}