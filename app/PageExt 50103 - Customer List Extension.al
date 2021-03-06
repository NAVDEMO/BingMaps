pageextension 50103 "freddyk BingMaps Cust List" extends "Customer List"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(Map; "freddyk BingMaps CustomerMap")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD ("No.");
                Caption = 'Customer Map';
                Visible = ShowFactBox;
            }
        }
    }

    actions
    {
        addfirst("&Customer")
        {
            action("Show All Customers on Bing Maps")
            {
                ApplicationArea = All;
                Image = Map;
                Enabled = EnableShowAll;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = codeunit "freddyk BingMaps Show All";
            }
        }
    }

    var 
        EnableShowAll: Boolean;
        ShowFactBox: Boolean;

    trigger OnOpenPage()
    var 
        BingMapsSetup: Codeunit "freddyk BingMaps Setup";
        BingMapsSettings: Record "freddyk BingMaps Settings";
    begin
        ShowFactBox := BingMapsSetup.GetSettings(BingMapsSettings, EnableShowAll);
    end;
}