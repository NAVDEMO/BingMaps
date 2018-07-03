codeunit 50102 "freddyk BingMaps Show All"
{
    trigger OnRun()
    var
        BingMapsSetup: Codeunit "freddyk BingMaps Setup";
        BingMapsSettings: Record "freddyk BingMaps Settings";
        wsUserOk: Boolean;
    begin
        if (BingMapsSetup.GetSettings(BingMapsSettings, wsUserOk) and wsUserOk) then
            hyperlink('https://bingmapsintegration.azurewebsites.net/Default.aspx?username=' + BingMapsSettings."Web Services Username" + '&publicodatabaseurl=' + GETURL(ClientType::OData) + '&bingmapskey=' + BingMapsSettings."BingMaps Key" + '&wskey=' + BingMapsSettings."Web Services Key");
    end;
}