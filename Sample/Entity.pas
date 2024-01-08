unit Entity;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections;

type
  TContact = class;
  TAddress = class;

  TPerson = class
  private
    FID: integer;
    FName: string;
    FActive: boolean;
    FSalary: Currency;
    FContacts: TObjectList<TContact>;
    FAddress: TAddress;
    FBirthDate: TDateTime;
    FPhoto: TStringStream;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: integer read FID write FID;
    property Name: string read FName write FName;
    property Active: boolean read FActive write FActive;
    property Salary: Currency read FSalary write FSalary;
    property BirthDate: TDateTime read FBirthDate write FBirthDate;
    property Photo: TStringStream read FPhoto write FPhoto;
    property Address: TAddress read FAddress write FAddress;
    property Contacts: TObjectList<TContact> read FContacts write FContacts;
  end;

  TContact = class
  private
    FID: integer;
    FDescription: string;
  public
    property ID: integer read FID write FID;
    property Description: string read FDescription write FDescription;
  end;

  TAddress = class
  private
    FStreet: string;
    FNeighborhood: string;
    FCity: string;
  public
    property Street: string read FStreet write FStreet;
    property Neighborhood: string read FNeighborhood write FNeighborhood;
    property City: string read FCity write FCity;
  end;

implementation

{ TPerson }

constructor TPerson.Create;
begin
  FContacts := TObjectList<TContact>.Create;
  FAddress := TAddress.Create;
  FPhoto := TStringStream.Create;
end;

destructor TPerson.Destroy;
begin
  FreeAndNil(FAddress);
  FreeAndNil(Contacts);
  FreeAndNil(FPhoto);
  inherited;
end;

end.
