page 50101 "freddyk BingMaps CustomerMap"
{
    PageType = CardPart;
    SourceTable = Customer;
    Caption = 'Customer Map';

    layout
    {
        area(content)
        {
            usercontrol(Map; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
            {
                ApplicationArea = All;

                trigger ControlAddInReady(callbackUrl: Text)
                begin
                    mapIsReady := true;
                    UpdateMap();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if mapIsReady then
            UpdateMap();
    end;

    procedure UpdateMap()
    var
        latitudeStr: Text;
        longitudeStr: Text;
        zoomStr: Text;
        embedUrl: Text;
        largeMapUrl: Text;
        directionsUrl: Text;
    begin
        latitudeStr := FORMAT(Latitude, 0, 9);
        longitudeStr := FORMAT(longitude, 0, 9);
        zoomStr := FORMAT(Zoom);
        embedUrl := 'https://www.bing.com/maps/embed?h=280&w=310&cp=' + LatitudeStr + '~' + longitudeStr + '&typ=d&sty=r&lvl=' + zoomStr;
        largeMapUrl := 'https://www.bing.com/maps?cp=' + latitudeStr + '~' + longitudeStr + '&amp;sty=r&amp;lvl=' + zoomStr + '&amp;sp=point.' + latitudeStr + '_' + longitudeStr + '_' + Name;
        directionsUrl := 'https://www.bing.com/maps/directions?cp=' + latitudeStr + '~' + longitudeStr + '&amp;sty=r&amp;lvl=' + zoomStr + '&amp;rtp=~pos.' + latitudeStr + '_' + longitudeStr;
        CurrPage.Map.SetContent('<div><iframe width="310" height="280" frameborder="1" src="' + embedUrl + '" scrolling="no"></iframe><div style="white-space: nowrap; text-align: center; width: 310px; padding: 6px 0;"><a target="_blank" style="text-decoration: none" href="' + largeMapUrl + '">View Larger Map</a> &nbsp; | &nbsp;<a target="_blank" style="text-decoration: none" href="' + directionsUrl + '">Get Directions</a></div></div>');
    end;

    var
        mapIsReady: Boolean;
}