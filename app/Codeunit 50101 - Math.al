codeunit 50101 "freddyk Math"
{

    procedure deg2rad(deg: Decimal): Decimal
    begin
        exit(deg * Pi() / 180);
    end;

    procedure rad2deg(rad: Decimal): Decimal
    begin
        exit(rad * 180 / Pi());
    end;

    procedure Pi(): Decimal;
    begin
        exit(3.1415926535897932384626);
    end;

    procedure sqrt(x: Decimal): Decimal
    begin
        exit(Power(x, 0.5));
    end;

    procedure sqr(x: Decimal): Decimal
    begin
        exit(Power(x, 2));
    end;

    procedure sin(x: Decimal): Decimal
    begin
        exit(x * (1 - (x * x) * (1 - (x * x) * (1 - (x * x) * (1 - (x * x) * (1 - (x * x) * (1 - (x * x) * (1 - (x * x) * (1 - (x * x) / (16 * 17)) / (14 * 15)) / (12 * 13)) / (10 * 11)) / (8 * 9)) / (6 * 7)) / (4 * 5)) / (2 * 3)));
    end;

    procedure cos(x: Decimal): Decimal
    begin
        exit(sin(x + PI() / 2));
    end;

    procedure atan(x: Decimal): Decimal
    var
        i: Integer;
        inverting: Boolean;
        result: Decimal;
    begin
        inverting := (x < -1) or (x > 1);
        IF inverting THEN
            x := 1 / x;

        result := 0;
        for i := 1 TO 100 do begin
            result += (Power(x, i) / i) - (Power(x, i + 2) / (i + 2));
            i += 3;
        end;

        if Inverting then
            if x > 0 then
                result := PI() / 2 - result
            else
                result := -PI() / 2 - result;

        exit(result);
    end;

    procedure sgn(x: Decimal): Decimal
    begin
        if (x >= 0) then
            exit(1)
        else
            exit(-1);
    end;

    procedure acos(x: Decimal): Decimal;
    begin
        if (x < 0) then
            exit(Pi() - acos(-x));
        if (x = 0) then
            exit(Pi() / 2)
        else
            exit(atan(sqrt(1 - x * x) / x));
    end;

    procedure atan2(x: Decimal; y: Decimal): Decimal
    begin
        if (x = 0) then
            if (y = 0) then
                Error('Division by zero')
            else
                exit(sgn(y) * Pi() / 2);
        if (x > 0) then
            exit(atan(y / x))
        else
            exit(atan(y / x) * sgn(y) * Pi());
    end;

    procedure GetDistanceFromLatLonInKm(lat1: Decimal; lon1: Decimal; lat2: Decimal; lon2: Decimal): Decimal
    var
        theta: Decimal;
        dist: Decimal;
    begin
        if (lat1 = lat2) and (lon1 = lon2) then 
            exit(0);
        theta := lon1 - lon2;
        dist := sin(deg2rad(lat1)) * sin(deg2rad(lat2)) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
        dist := acos(dist);
        dist := rad2deg(dist);
        exit(dist * 111.18957696);
    end;

    procedure KmToLatitude(km: Decimal): Decimal
    begin
        exit(km / 111.18957696);
    end;

    procedure KmToLongitude(km: Decimal; lat: Decimal): Decimal
    begin
        exit(km / (cos(deg2rad(lat)) * 111.18957696));
    end;

}