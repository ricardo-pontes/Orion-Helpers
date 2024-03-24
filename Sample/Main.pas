unit Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Entity, Orion.Helpers, System.JSON;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Person : TPerson;
  Contact : TContact;
begin
  Person := TPerson.Create;
  Person.ID := 7;
  Person.Name := 'Test';
  Person.Active := True;
  Person.Salary := 5500.69;
  Person.BirthDate := StrToDate('24/06/1987');
  Person.Photo.LoadFromFile('E:\Desenvolvimento\Projetos\Orion-Helpers\images.jpg');
  Contact := TContact.Create;
  Contact.ID := 1;
  Contact.Description := 'Contact 1';
  Person.Contacts.Add(Contact);
  try
    Memo1.Text := Person.ToJSONString(True);
  finally
    FreeAndNil(Person);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Person : TPerson;
  Contact : TContact;
  I: Integer;
  Persons : TObjectList<TPerson>;
begin
  Persons := TObjectList<TPerson>.Create;
  try
    for I := 1 to 1000 do
    begin
      Person := TPerson.Create;
      Person.ID := I;
      Person.Name := 'Test' + I.ToString;
      Person.Active := True;
      Person.Salary := 5500.69;
      Person.BirthDate := StrToDate('24/06/1987');
      Person.Address.Street := 'Rua ' + i.ToString;
      Person.Address.Neighborhood := 'Neighborhood ' + i.ToString;
      Person.Address.City := 'City ' + i.ToString;

      Contact := TContact.Create;
      Contact.ID := I;
      Contact.Description := 'Contact ' + I.ToString;
      Person.Contacts.Add(Contact);
      Persons.Add(Person);
    end;

    Memo1.Text := Persons.ToJSONString(True);
  finally
    FreeAndNil(Persons);
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Person, PersonedJSON : TPerson;
  Contact : TContact;
  JSONObject : TJSONObject;
begin
  Person := TPerson.Create;
  try
    Person.ID := 7;
    Person.Name := 'Test';
    Person.Active := True;
    Person.Salary := 5500.69;
    Person.BirthDate := StrToDate('24/06/1987');
    Person.Photo.LoadFromFile('E:\Desenvolvimento\Projetos\Orion-Helpers\images.jpg');
    Person.Address.Street := 'Street Test';
    Person.Address.Neighborhood := 'Neighborhood Test';
    Person.Address.City := 'City Test';
    Contact := TContact.Create;
    Contact.ID := 1;
    Contact.Description := 'Contact 1';
    Person.Contacts.Add(Contact);
    JSONObject := Person.ToJSONObject;
    PersonedJSON := TPerson.Create;
    PersonedJSON.FromJSON(JSONObject);
    Memo1.Text := PersonedJSON.ToJSONString(True);
    Memo1.Lines.Add(PersonedJSON.Photo.Size.ToString);
  finally
    FreeAndNil(Person);
    if Assigned(PersonedJSON) then
      FreeAndNil(PersonedJSON);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Person : TPerson;
  Persons : TObjectList<TPerson>;
  Contact : TContact;
  I, X: Integer;
  PersonedJSONArray : TJSONArray;

begin
  Persons := TObjectList<TPerson>.Create;
  PersonedJSONArray := TJSONArray.Create;
  try
    for I := 1 to 100 do
    begin
      Person := TPerson.Create;
      Person.ID := I;
      Person.Name := 'Test' + I.ToString;
      Person.Active := True;
      Person.Salary := 5500.69;
      Person.BirthDate := StrToDate('24/06/1987');
      Person.Photo.LoadFromFile('E:\Desenvolvimento\Projetos\Orion-Helpers\images.jpg');
      Person.Address.Street := 'Rua ' + i.ToString;
      Person.Address.Neighborhood := 'Neighborhood ' + i.ToString;
      Person.Address.City := 'City ' + i.ToString;
      for X := 1 to 3 do
      begin
        Contact := TContact.Create;
        Contact.ID := X;
        Contact.Description := 'Contact ' + X.ToString;
        Person.Contacts.Add(Contact);
      end;
      PersonedJSONArray.Add(Person.ToJSONObject);
      Person.Free;
    end;
    Persons.FromJSON(PersonedJSONArray);
    Memo1.Text := Persons.ToJSONString(True);
  finally
    FreeAndNil(Persons);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  Persons : TObjectList<TPerson>;
  Person : TPerson;
  Contact : TContact;
  I : integer;
begin
  Persons := TObjectList<TPerson>.Create;
  try
    for I := 1 to 1000 do
    begin
      Person := TPerson.Create;
      Person.ID := I;
      Person.Name := 'Test' + I.ToString;
      Person.Active := True;
      Person.Salary := 5500.69;
      Person.BirthDate := StrToDate('24/06/1987');
      Person.Address.Street := 'Rua ' + i.ToString;
      Person.Address.Neighborhood := 'Neighborhood ' + i.ToString;
      Person.Address.City := 'City ' + i.ToString;

      Contact := TContact.Create;
      Contact.ID := I;
      Contact.Description := 'Contact ' + I.ToString;
      Person.Contacts.Add(Contact);
      Persons.Add(Person);
    end;

    if Persons.ContainsItemByFieldValue<integer>('ID', StrToInt(Edit1.Text)) then
      Memo1.Text := 'True'
    else
      Memo1.Text := 'False'
  finally
    FreeAndNil(Persons);
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  Persons : TObjectList<TPerson>;
  Person : TPerson;
  Contact : TContact;
  I : integer;
begin
  Persons := TObjectList<TPerson>.Create;
  try
    for I := 1 to 1000 do
    begin
      Person := TPerson.Create;
      Person.ID := I;
      Person.Name := 'Test' + I.ToString;
      Person.Active := True;
      Person.Salary := 5500.69;
      Person.BirthDate := StrToDate('24/06/1987');
      Person.Address.Street := 'Rua ' + i.ToString;
      Person.Address.Neighborhood := 'Neighborhood ' + i.ToString;
      Person.Address.City := 'City ' + i.ToString;

      Contact := TContact.Create;
      Contact.ID := I;
      Contact.Description := 'Contact ' + I.ToString;
      Person.Contacts.Add(Contact);
      Persons.Add(Person);
    end;

    var FoundedPerson := Persons.GetCopyOfItemByKey<TPerson>('ID', Edit1.Text);
    try
      Memo1.Text := FoundedPerson.ToJSONString(True);
    finally
      FoundedPerson.Free;
    end;
  finally
    FreeAndNil(Persons);
  end;
end;

end.
