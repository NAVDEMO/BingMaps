page 50104 "BingMaps CustomerLocation"
{
    PageType = Card;
    SourceTable = Customer;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code";"Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Geocoded;Geocoded)
                {
                    ApplicationArea = All;
                }
                field(Latitude;Latitude)
                {
                    ApplicationArea = All;
                }
                field(Longitude;Longitude)
                {
                    ApplicationArea = All;
                }
                field(URL; URL)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var 
        URL: Text;

    trigger OnAfterGetRecord()
    begin
        URL := GetUrl(ClientType::Web, CompanyName(), ObjectType::Page, Page::"Customer Card", Rec);
    end;
}