unit Orion.Helpers;

interface

uses
  System.JSON,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Orion.Helpers.Reflections;

type
  TOrionHelper = class helper for TObject
  private

  public
    function ToJSONObject : TJSONObject; overload;
    function ToJSONArray : TJSONArray;
    function ToJSONString(aPretty : boolean = False) : string; overload;
    procedure FromJSON(aJSONObject : TJSONObject; aFreeJSONObject : boolean = True); overload;
    procedure FromJSON(aJSONArray : TJSONArray; aFreeJSONArray : boolean = True); overload;
    procedure FromJSON(aJSONString : string); overload;
    procedure FromObject(aObject: TObject; aFreeAfterFinish : boolean = True);
  end;

implementation

{ TOrionHelper }

procedure TOrionHelper.FromJSON(aJSONArray: TJSONArray; aFreeJSONArray : boolean);
var
  I : integer;
  Obj : TObject;
  Reflections : TOrionReflections;
const
  NOT_FREE_ON_TERMINATE = False;
begin
  Reflections := TOrionReflections.Create;
  try
    TObjectList<TObject>(Self).Clear;
    for I := 0 to Pred(aJSONArray.Count) do
    begin
      Obj := Reflections.GetObjectInstance(TObjectList<TObject>(Self));
      Obj.FromJSON(TJSONObject(aJSONArray.Items[I]), NOT_FREE_ON_TERMINATE);
      TObjectList<TObject>(Self).Add(Obj);
    end;
  finally
    FreeAndNil(Reflections);
    if aFreeJSONArray then
      FreeAndNil(aJSONArray);
  end;
end;

procedure TOrionHelper.FromJSON(aJSONObject: TJSONObject; aFreeJSONObject : boolean);
var
  Reflections : TOrionReflections;
  Collections : TDictionary<string, TObjectList<TObject>>;
  JSONChildObjects : TDictionary<string, TJSONObject>;
  JSONChildArrays : TDictionary<string, TJSONArray>;
  ChildArray : TJSONArray;
  Key : string;
  Obj : TObject;
  I: Integer;
begin
  JSONChildArrays := nil;
  JSONChildObjects := nil;
  Collections := nil;
  Reflections := TOrionReflections.Create;
  try
    Reflections.JSONObjectToObject(aJSONObject, Self);
    if Reflections.ContainObject(Self) then
    begin
      JSONChildObjects := Reflections.GetObjects(aJSONObject);
      for Key in JSONChildObjects.Keys do
      begin
        Reflections.JSONObjectToObject(JSONChildObjects.Items[Key], Reflections.GetObject(Self, Key));
      end;
    end;
    if Reflections.ContainsCollections(Self) then
    begin
      Collections := Reflections.GetCollections(Self);
      JSONChildArrays := Reflections.GetCollections(aJSONObject);
      for Key in Collections.Keys do
      begin
        ChildArray := JSONChildArrays.Items[Reflections.GetFormattedPropertyName(Key)];
        for I := 0 to Pred(ChildArray.Count) do
        begin
          Obj := Reflections.GetObjectInstance(Collections.Items[Key]);
          Obj.FromJSON(TJSONObject(ChildArray.Items[I]), False);
          Collections.Items[Key].Add(Obj);
        end;
      end;
    end;
  finally
    FreeAndNil(Reflections);
    if Assigned(JSONChildObjects) then
      FreeAndNil(JSONChildObjects);
    if Assigned(JSONChildArrays) then
      FreeAndNil(JSONChildArrays);
    if aFreeJSONObject then
      FreeAndNil(aJSONObject);
    if Assigned(Collections) then
      FreeAndNil(Collections);
  end;
end;

procedure TOrionHelper.FromJSON(aJSONString: string);
var
  JSONValue : TJSONValue;
begin
  JSONValue := TJSONValue.ParseJSONValue(aJSONString);
  if JSONValue is TJSONObject then
    Self.FromJSON(TJSONObject(JSONValue))
  else if JSONValue is TJSONArray then
    Self.FromJSON(TJSONArray(JSONValue));
end;

procedure TOrionHelper.FromObject(aObject: TObject; aFreeAfterFinish: boolean);
var
  Reflections : TOrionReflections;
begin
  Reflections := TOrionReflections.Create;
  try

  finally
    FreeAndNil(Reflections);
  end;
end;

function TOrionHelper.ToJSONArray: TJSONArray;
var
  Reflections : TOrionReflections;
  Obj: TObject;
  JSONObject : TJSONObject;
begin
  Result := nil;
  Reflections := TOrionReflections.Create;
  try
    if not Self.ClassName.ToLower.Contains('tobjectlist<') then
      Exit;

    Result := TJSONArray.Create;
    for Obj in TObjectList<TObject>(Self) do
    begin
      JSONObject := Obj.ToJSONObject;
      Result.AddElement(JSONObject);
    end;
  finally
    Reflections.Free;
  end;
end;

function TOrionHelper.ToJSONObject: TJSONObject;
var
  Reflections : TOrionReflections;
  Collections : TDictionary<string, TObjectList<TObject>>;
  ChildObjects : TDictionary<string, TObject>;
  Key : string;
begin
  Collections := nil;
  ChildObjects := nil;
  Result := TJSONObject.Create;
  Reflections := TOrionReflections.Create;
  try
    Reflections.ObjectToJSONObject(Self, Result);
    if Reflections.ContainObject(Self) then
    begin
      ChildObjects := Reflections.GetObjects(Self);
      for Key in ChildObjects.Keys do
      begin
        if ChildObjects.Items[Key].InheritsFrom(TStream) then
          Result.AddPair(Reflections.GetFormattedPropertyName(Key), Reflections.StreamFromBase64(TStream(ChildObjects.Items[Key])))
        else
          Result.AddPair(Reflections.GetFormattedPropertyName(Key), ChildObjects.Items[Key].ToJSONObject);
      end;
    end;
    if Reflections.ContainsCollections(Self) then
    begin
      Collections := Reflections.GetCollections(Self);
      for Key in Collections.Keys do
        Reflections.IncCollectionInJsonObject(Collections.Items[Key], Key, Result);
    end;
  finally
    FreeAndNil(Reflections);
    if Assigned(Collections) then
      FreeAndNil(Collections);
    if Assigned(ChildObjects) then
      FreeAndNil(ChildObjects);
  end;
end;

function TOrionHelper.ToJSONString(aPretty: boolean): string;
var
  JSONObject : TJSONObject;
  JSONArray : TJSONArray;
begin
  if Self.ClassName.ToLower.Contains('tobjectlist<') then
  begin
    JSONArray := Self.ToJSONArray;
    try
      if aPretty then
        Result := JSONArray.Format
      else
        Result := JSONArray.ToJSON;
    finally
      JSONArray.Free;
    end;
  end
  else
  begin
    JSONObject := Self.ToJSONObject;
    try
      if aPretty then
        Result := JSONObject.Format
      else
        Result := JSONObject.ToJSON;
    finally
      JSONObject.Free;
    end;
  end;
end;

end.
