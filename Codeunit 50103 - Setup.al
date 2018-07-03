codeunit 50103 "freddyk BingMaps Setup"
{
    procedure SetBingMapsSettings(SettingsStr: Text)
    var
        BingMapsGeocode: Codeunit "freddyk BingMaps Geocode";
        BingMapsSettings: Record "freddyk BingMaps Settings";
        ErrorText: Text;
        Settings: JsonObject;
        Token: JsonToken;
    begin
        if not Settings.ReadFrom(SettingsStr) then
            Error('Argument error');
        GetSettings(BingMapsSettings);
        if Settings.Get('BingMapsKey', Token) then
            BingMapsSettings."BingMaps Key" := CopyStr(Token.AsValue().AsText(), 1, MaxStrLen(BingMapsSettings."BingMaps Key"));
        if Settings.Get('WebServicesUsername', Token) then
            BingMapsSettings."Web Services Username" := CopyStr(Token.AsValue().AsText(), 1, MaxStrLen(BingMapsSettings."Web Services Username"));
        if Settings.Get('WebServicesKey', Token) then
            BingMapsSettings."Web Services Key" := CopyStr(Token.AsValue().AsText(), 1, MaxStrLen(BingMapsSettings."Web Services Key"));
        BingMapsSettings.Modify();
        if TestSettings(BingMapsSettings, ErrorText) then begin
            BingMapsSettings.Modify();
            BingMapsGeocode.Run();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Connection", 'OnRegisterServiceConnection', '', true, true)]
    procedure RegisterServiceConnection(Var ServiceConnection: Record "Service Connection")
    var
        BingMapsSetup: Codeunit "freddyk BingMaps Setup";
        BingMapsSettings: Record "freddyk BingMaps Settings";
        RecRef: RecordRef;
    begin
        if not BingMapsSetup.GetSettings(BingMapsSettings) then
            if not BingMapsSettings.WritePermission() then
                exit;
        RecRef.GETTABLE(BingMapsSettings);
        ServiceConnection.Status := ServiceConnection.Status::Disabled;
        IF BingMapsSettings."BingMaps Key OK" THEN
            ServiceConnection.Status := ServiceConnection.Status::Enabled;
        ServiceConnection.InsertServiceConnection(ServiceConnection, RecRef.RecordId(), 'BingMaps Integration Setup', '', PAGE::"freddyk BingMaps Setup");
    end;

    procedure TestSettings(var BingMapsSettings: record "freddyk BingMaps Settings"; var ErrorText: Text): Boolean;
    var
        tempCustomer: Record Customer temporary;
    begin
        if BingMapsSettings."BingMaps Key" = '' then begin
            ErrorText := 'BingMaps Key not defined';
            exit(false);
        end;
        tempCustomer.Init();
        tempCustomer.Name := 'Microsoft';
        tempCustomer.Address := 'One Microsoft Way';
        tempCustomer."Country/Region Code" := 'US';
        tempCustomer.City := 'Redmond';
        if tempCustomer.GeocodeCustomer1(ErrorText) then begin
            BingMapsSettings."BingMaps Key OK" := true;
            Exit(true);
        end;
        exit(false);
    end;

    procedure SetupBingMapsIntegration(notification: Notification);
    var
        BingMapsSetup: Page "freddyk BingMaps Setup";
    begin
        BingMapsSetup.RunModal();
    end;

    procedure GetSettings(var BingMapsSettings: Record "freddyk BingMaps Settings"): Boolean
    begin
        if not BingMapsSettings.FindFirst() then begin
            if not BingMapsSettings.WritePermission() then
                exit(false);
            BingMapsSettings.Init();
            BingMapsSettings.Insert();
        end;
        exit(BingMapsSettings."BingMaps Key OK");
    end;

    procedure GetSettings2(var BingMapsSettings: Record "freddyk BingMaps Settings"; var WsUserSet: Boolean): Boolean
    begin
        if (not GetSettings(BingMapsSettings)) then
            exit(false);
        WsUserSet := (BingMapsSettings."Web Services Username" <> '') and (BingMapsSettings."Web Services Key" <> '');
        exit(true);
    end;

}