page 50102 "freddyk BingMaps Setup"
{
    // version BingMaps

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "freddyk BingMaps Settings";
    UsageCategory = Administration;
    Caption = 'BingMaps Setup';

    layout
    {
        area(content)
        {
            group(Welcome)
            {
                Caption = 'Welcome to the BingMaps Integration App';

                field(test; '')
                {
                    ApplicationArea = All;
                    Caption = 'In order to use the App, you will need to specify a BingMaps Key. Press the AssistEdit button to get assistance on how to create your own key.';
                    ShowCaption = true;
                }
            }
            group(General)
            {
                field("BingMaps Key"; "BingMaps Key")
                {
                    ApplicationArea = All;
                    Width = 80;

                    trigger OnAssistEdit()
                    begin
                        HYPERLINK('http://msdn.microsoft.com/en-us/library/ff428642.aspx');
                    end;
                }
                field("BingMaps Key OK"; "BingMaps Key OK")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Web Services Username"; "Web Services Username")
                {
                    ApplicationArea = All;
                }
                field("Web Services Key"; "Web Services Key")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(GeocodeAll)
            {
                ApplicationArea = All;
                Caption = 'Geocode All Customers';
                Image = Map;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    sessionId: Integer;
                    BingMapsSetup: Codeunit "freddyk BingMaps Setup";
                    ErrorText: Text;
                begin
                    if not BingMapsSetup.TestSettings(Rec, ErrorText) then
                        Message(ErrorText)
                    else
                        if StartSession(sessionId, Codeunit::"freddyk BingMaps Geocode") then
                            Message('You can continue to work while customers are being geocoded!');
                end;
            }
            action(TestBingMapsKey)
            {
                ApplicationArea = All;
                Caption = 'Test BingMaps Key';
                Image = TestFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    BingMapsSetup: Codeunit "freddyk BingMaps Setup";
                    ErrorText: Text;
                begin
                    if BingMapsSetup.TestSettings(Rec, ErrorText) then
                        Message('BingMaps Key has been tested and is OK')
                    else
                        Message(ErrorText);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}

