unit Orion.Helpers.Reflections;

interface

uses
  System.Rtti,
  System.JSON,
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  System.Generics.Collections,
  System.NetEncoding,
  System.TypInfo;

type
  TGetProperty = record
    Obj : TObject;
    Prop : TRttiProperty;
  end;

  TOrionReflections = class
  private
    procedure ClearObject(aObject : TObject);
    procedure InternalClearObject(aObject: TObject);
    function isDate(aProperty : TRttiProperty) : boolean;
    function isCollection(aRttiProperty : TRttiProperty; aObject : TObject) : boolean;
    function GetProperty(aObject : TObject; aEntityFieldName : string) : TGetProperty;
  public
    procedure Base64FromStream(aBase64 : string; aStream : TStream);
    function CreateClass(aClassType : TClass): TObject; overload;
    function CreateClass(aQualifiedClassName : string): TObject; overload;
    procedure ObjectToJSONObject(aObject : TObject; aJSONObject : TJSONObject);
    function ContainsCollections(aObject : TObject) : boolean;
    function ContainObject(aObject: TObject) : boolean;
    procedure FromObject(aObject: TObject; aFreeAfterFinish : boolean = True);
    function GetCollections(aObject : TObject) : TDictionary<string, TObjectList<TObject>>; overload;
    function GetCollections(aObject : TJSONObject) : TDictionary<string, TJSONArray>; overload;
    function GetFormattedPropertyName(aPropertyName : string) : string;
    function GetObjects(aObject : TObject) : TDictionary<string, TObject>; overload;
    function GetObjects(aObject : TJSONObject) : TDictionary<string, TJSONObject>; overload;
    function GetObject(aObject : TObject; aObjectName : string) : TObject;
    function GetObjectInstance(aList: TObjectList<TObject>): TObject;
    procedure IncCollectionInJsonObject(aCollection: TObject; aCollectionName : string; aJSONObject :TJSONObject);
    procedure JSONObjectToObject(aJSONObject : TJSONObject; aObject : TObject);
    procedure ObjectToObject(aSource, aTarget: TObject);
    function StreamFromBase64(aStream : TStream) : string;
  end;

implementation

{ TOrionReflections }

procedure TOrionReflections.Base64FromStream(aBase64: string; aStream: TStream);
var
  Base64Stream : TStringStream;
begin
  Base64Stream := TStringStream.Create(aBase64);
  try
    aStream.Position := 0;
    Base64Stream.Position := 0;
    TNetEncoding.Base64String.Decode(Base64Stream, aStream);
  finally
    FreeAndNil(Base64Stream);
  end;
end;

procedure TOrionReflections.ClearObject(aObject : TObject);
begin
  if not Assigned(aObject) then
    Exit;

  if (Self.ClassName.ToLower.Contains('tObjectlist<')) then
    TObjectList<TObject>(aObject).Clear
  else
    InternalClearObject(aObject);
end;

function TOrionReflections.ContainObject(aObject: TObject): boolean;
var
  RttiType : TRttiType;
  RttiProperty : TRttiProperty;
begin
  Result := False;
  RttiType := TRttiContext.Create.GetType(aObject.ClassInfo);
  for RttiProperty in RttiType.GetProperties do
    if RttiProperty.GetValue(Pointer(aObject)).IsObject and not isCollection(RttiProperty, aObject) then
      Result := True;
end;

function TOrionReflections.ContainsCollections(aObject: TObject): boolean;
var
  RttiType : TRttiType;
  RttiProperty : TRttiProperty;
begin
  Result := False;
  RttiType := TRttiContext.Create.GetType(aObject.ClassInfo);
  for RttiProperty in RttiType.GetProperties do
    if RttiProperty.PropertyType.Name.ToLower.Contains('tobjectlist<') then
      Result := True;
end;

function TOrionReflections.CreateClass(aQualifiedClassName: string): TObject;
var
  RttiType : TRttiType;
  RttiMethod: TRttiMethod;
begin
  Result := nil;
  RttiType := TRttiContext.Create.FindType(aQualifiedClassName);
  for RttiMethod in RttiType.GetMethods do
  begin
    if RttiMethod.IsConstructor then
    begin
      Result := RttiMethod.Invoke(RttiType.AsInstance.MetaclassType, []).AsObject;
      Exit;
    end;
  end;
end;

procedure TOrionReflections.FromObject(aObject: TObject;
  aFreeAfterFinish: boolean);
var
  lObject: TObject;
begin
  if not Assigned(Self) then
    Exit;
  if not Assigned(aObject) then
    Exit;
  if (aObject.ClassName.Contains('TObjectList<')) then
    TObjectList<TObject>(Self).Clear
  else
    InternalClearObject(Self);
  if (aObject.ClassName.Contains('TObjectList<')) and (Self.ClassName.Contains('TObjectList<')) then begin
    TObjectList<TObject>(Self).Clear;
    TObjectList<TObject>(aObject).OwnsObjects := False;
    for lObject in TObjectList<TObject>(aObject) do begin
      TObjectList<TObject>(Self).Add(lObject);
    end;
  end
  else if (aObject.ClassName = Self.ClassName) then begin
    ObjectToObject(aObject, Self);
  end;
  if aFreeAfterFinish then
    FreeAndNil(aObject);
end;

function TOrionReflections.CreateClass(aClassType: TClass): TObject;
var
  RttiType : TRttiType;
  RttiMethod: TRttiMethod;
begin
  Result := nil;
  RttiType := TRttiContext.Create.GetType(aClassType);
  for RttiMethod in RttiType.GetMethods do
  begin
    if RttiMethod.IsConstructor then
    begin
      Result := RttiMethod.Invoke(aClassType, []).AsObject;
      Exit;
    end;
  end;
end;

function TOrionReflections.GetCollections(aObject: TObject): TDictionary<string, TObjectList<TObject>>;
var
  RttiType : TRttiType;
  RttiProperty: TRttiProperty;
const
  NOT_OWNS_OBJECTS = False;
begin
  Result := TDictionary<string, TObjectList<TObject>>.Create;
  RttiType := TRttiContext.Create.GetType(aObject.ClassInfo);
  for RttiProperty in RttiType.GetProperties do
  begin
    if isCollection(RttiProperty, aObject) then
      Result.Add(RttiProperty.Name, TObjectList<TObject>(RttiProperty.GetValue(Pointer(aObject)).AsObject));
  end;
end;

function TOrionReflections.GetCollections(aObject: TJSONObject): TDictionary<string, TJSONArray>;
var
  I: Integer;
begin
  Result := TDictionary<string, TJSONArray>.Create;
  for I := 0 to Pred(aObject.Count) do
  begin
    if aObject.Pairs[I].JsonValue is TJSONArray then
      Result.Add(aObject.Pairs[I].JsonString.Value, aObject.Pairs[I].JsonValue as TJSONArray);
  end;
end;

function TOrionReflections.GetFormattedPropertyName(
  aPropertyName: string): string;
begin
  Result := LowerCase(aPropertyName.Chars[0]) + aPropertyName.Remove(0, 1);
end;

function TOrionReflections.GetObject(aObject : TObject; aObjectName: string): TObject;
var
  RttiType : TRttiType;
  RttiProperty: TRttiProperty;
begin
  RttiType := TRttiContext.Create.GetType(aObject.ClassInfo);
  RttiProperty := RttiType.GetProperty(UpperCase(aObjectName.Chars[0]) + aObjectName.Remove(0, 1));
  Result := RttiProperty.GetValue(Pointer(aObject)).AsObject;
end;

function TOrionReflections.GetObjectInstance(
  aList: TObjectList<TObject>): TObject;
var
  lContext : TRttiContext;
  lType : TRttiType;
  lTypeName : string;
  lMethodType : TRttiMethod;
  lMetaClass : TClass;
begin
  lTypeName := Copy(aList.QualifiedClassName, 41, aList.QualifiedClassName.Length-41);
  lType := lContext.FindType(lTypeName);
  lMetaClass := nil;
  lMethodType := nil;
  if Assigned(lType) then
  begin
    for lMethodType in lType.GetMethods do
    begin
      if lMethodType.HasExtendedInfo and lMethodType.IsConstructor and (Length(lMethodType.GetParameters) = 0) then
      begin
        lMetaClass := lType.AsInstance.MetaclassType;
        Break;
      end;
    end;
  end;
  Result := lMethodType.Invoke(lMetaClass, []).AsObject;
end;

function TOrionReflections.GetObjects(aObject: TJSONObject): TDictionary<string, TJSONObject>;
var
  I: Integer;
begin
  Result := TDictionary<string, TJSONObject>.Create;
  for I := 0 to Pred(aObject.Count) do
  begin
    if aObject.Pairs[I].JsonValue is TJSONObject then
      Result.Add(aObject.Pairs[I].JsonString.Value, aObject.Pairs[I].JsonValue as TJSONObject);
  end;
end;

function TOrionReflections.GetObjects(aObject: TObject): TDictionary<string, TObject>;
var
  RttiType : TRttiType;
  RttiProperty: TRttiProperty;
const
  NOT_OWNS_OBJECTS = False;
begin
  Result := TDictionary<string, TObject>.Create;
  RttiType := TRttiContext.Create.GetType(aObject.ClassInfo);
  for RttiProperty in RttiType.GetProperties do
  begin
    if RttiProperty.GetValue(Pointer(aObject)).IsObject and not isCollection(RttiProperty, aObject) then
      Result.Add(RttiProperty.Name, RttiProperty.GetValue(Pointer(aObject)).AsObject);
  end;
end;

function TOrionReflections.GetProperty(aObject: TObject;aEntityFieldName: string): TGetProperty;
var
  RttiContext : TRttiContext;
  RttiType : TRttiType;
  Strings : TArray<string>;
  I : integer;
begin
  try
    Result.Obj := nil;
    Result.Prop := nil;
    RttiContext := TRttiContext.Create;
    RttiType := RttiContext.GetType(aObject.ClassInfo);
    if aEntityFieldName.Contains('.') then
    begin
      Strings := aEntityFieldName.Split(['.']);
      for I := 0 to Pred(Length(Strings)) do
      begin
        if Assigned(Result.Obj) then
          Result := GetProperty(Result.Obj, Strings[i+1])
        else
          Result := GetProperty(aObject, Strings[i]);
        if Result.Prop.PropertyType.TypeKind = tkClass then
          Result := GetProperty(Result.Obj, Strings[I+1]);
        if Result.Prop.Name = Strings[Pred(Length(Strings))] then
          Break;
      end;
    end
    else
    begin
      Result.Prop := RttiType.GetProperty(aEntityFieldName);

      if (Result.Prop.PropertyType.TypeKind = tkClass) and not (Result.Prop.GetValue(Pointer(aObject)).AsObject.ClassName.Contains('TObjectList<')) then
        Result.Obj := Result.Prop.GetValue(Pointer(aObject)).AsObject
      else
        Result.Obj := aObject;
    end;
  except on E: Exception do
    raise Exception.Create('Could not get property ' + aEntityFieldName);
  end;
end;

procedure TOrionReflections.IncCollectionInJsonObject(aCollection: TObject; aCollectionName : string;
  aJSONObject: TJSONObject);
var
  Collection : TObjectList<TObject>;
  Obj: TObject;
  JSONObject : TJSONObject;
  JSONArray : TJSONArray;
begin
  Collection := TObjectList<TObject>(aCollection);
  JSONArray := TJSONArray.Create;
  for Obj in Collection do
  begin
    JSONObject := TJSONObject.Create;
    ObjectToJSONObject(Obj, JSONObject);
    JSONArray.AddElement(JSONObject);
  end;
  aJSONObject.AddPair(GetFormattedPropertyName(aCollectionName), JSONArray);
end;

procedure TOrionReflections.InternalClearObject(aObject: TObject);
var
  RttiProperty: TRttiProperty;
  RttiType : TRttiType;
  RttiContext : TRttiContext;
begin
  RttiContext := TRttiContext.Create;
  RttiType := RttiContext.GetType(aObject.ClassInfo);
  for RttiProperty in RttiType.GetProperties do begin
    case RttiProperty.PropertyType.TypeKind of
      tkUnknown: ;
      tkInteger: RttiProperty.SetValue(Pointer(aObject), 0);
      tkChar: RttiProperty.SetValue(Pointer(aObject), '');
      tkEnumeration: RttiProperty.SetValue(Pointer(aObject), False);
      tkFloat: RttiProperty.SetValue(Pointer(aObject), 0);
      tkString: RttiProperty.SetValue(Pointer(aObject), '');
      tkSet: ;
      tkClass:  begin
        if RttiProperty.GetValue(Pointer(aObject)).AsObject.ClassName.Contains('TObjectList<') then
          TObjectList<TObject>(RttiProperty.GetValue(Pointer(aObject)).AsObject).Clear
        else if RttiProperty.GetValue(Pointer(aObject)).AsObject.ClassName.Contains('StringStream') then
          TStringStream(RttiProperty.GetValue(Pointer(aObject)).AsObject).Clear
        else
          InternalClearObject(RttiProperty.GetValue(Pointer(aObject)).AsObject);
      end;
      tkMethod: ;
      tkWChar: RttiProperty.SetValue(Pointer(aObject), '');
      tkLString: RttiProperty.SetValue(Pointer(aObject), '');
      tkWString: RttiProperty.SetValue(Pointer(aObject), '');
      tkVariant: ;
      tkArray: ;
      tkRecord: ;
      tkInterface: ;
      tkInt64: RttiProperty.SetValue(Pointer(aObject), 0);
      tkDynArray: ;
      tkUString: RttiProperty.SetValue(Pointer(aObject), '');
      tkClassRef: ;
      tkPointer: ;
      tkProcedure: ;
      tkMRecord: ;
    end;
  end;

end;

function TOrionReflections.isCollection(aRttiProperty: TRttiProperty; aObject: TObject): boolean;
begin
  Result := (aRttiProperty.GetValue(Pointer(aObject)).IsObject) and (aRttiProperty.GetValue(Pointer(aObject)).AsObject.ClassName.ToLower.Contains('tobjectlist<'))
end;

function TOrionReflections.isDate(aProperty: TRttiProperty): boolean;
begin
  Result := (aProperty.PropertyType.Name.ToLower = 'tdatetime') or (aProperty.PropertyType.Name.ToLower = 'tdate');
end;

procedure TOrionReflections.JSONObjectToObject(aJSONObject: TJSONObject; aObject: TObject);
var
  RttiType : TRttiType;
  RttiProperty : TRttiProperty;
begin
  ClearObject(aObject);
  RttiType := TRttiContext.Create.GetType(aObject.ClassInfo);
  for RttiProperty in RttiType.GetProperties do
  begin
    case RttiProperty.PropertyType.TypeKind of
      tkUnknown: ;
      tkInteger: RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<integer>(GetFormattedPropertyName(RttiProperty.Name)));
      tkChar: RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<string>(GetFormattedPropertyName(RttiProperty.Name)));
      tkEnumeration: RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<boolean>(GetFormattedPropertyName(RttiProperty.Name)));
      tkFloat:
      begin
        if isDate(RttiProperty) then
          RttiProperty.SetValue(Pointer(aObject), ISO8601ToDate(aJSONObject.GetValue<string>(GetFormattedPropertyName(RttiProperty.Name))))
        else
          RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<Extended>(GetFormattedPropertyName(RttiProperty.Name)));
      end;
      tkString: RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<string>(GetFormattedPropertyName(RttiProperty.Name)));
      tkSet: ;
      tkClass:
      begin
        if RttiProperty.GetValue(Pointer(aObject)).AsObject.InheritsFrom(TStream) then
          Base64FromStream(aJSONObject.GetValue<string>(GetFormattedPropertyName(RttiProperty.Name)), TStream(RttiProperty.GetValue(Pointer(aObject)).AsObject));
      end;
      tkMethod: ;
      tkWChar: RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<string>(GetFormattedPropertyName(RttiProperty.Name)));
      tkLString: RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<string>(GetFormattedPropertyName(RttiProperty.Name)));
      tkWString: RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<string>(GetFormattedPropertyName(RttiProperty.Name)));
      tkVariant: ;
      tkArray: ;
      tkRecord: ;
      tkInterface: ;
      tkInt64: RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<Int64>(GetFormattedPropertyName(RttiProperty.Name)));
      tkDynArray: ;
      tkUString: RttiProperty.SetValue(Pointer(aObject), aJSONObject.GetValue<string>(GetFormattedPropertyName(RttiProperty.Name)));
      tkClassRef: ;
      tkPointer: ;
      tkProcedure: ;
      tkMRecord: ;
    end;
  end;
end;

procedure TOrionReflections.ObjectToJSONObject(aObject: TObject; aJSONObject: TJSONObject);
var
  RttiContext : TRttiContext;
  RttiType : TRttiType;
  RttiProperty: TRttiProperty;
  PropertyName : string;
begin
  RttiContext := TRttiContext.Create;
  RttiType := RttiContext.GetType(aObject.ClassInfo);
  for RttiProperty in RttiType.GetProperties do
  begin
    PropertyName := GetFormattedPropertyName(RttiProperty.Name);
    case RttiProperty.PropertyType.TypeKind of
      tkUnknown: ;
      tkInteger: aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).AsInteger);
      tkChar: ;
      tkEnumeration: aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).AsBoolean);
      tkFloat:
      begin
        if isDate(RttiProperty) then
          aJSONObject.AddPair(PropertyName, DateToISO8601(RttiProperty.GetValue(Pointer(aObject)).AsExtended))
        else
          aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).AsExtended);
      end;
      tkString: aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).AsString);
      tkSet: ;
      tkClass: ;
      tkMethod: ;
      tkWChar: aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).AsString);
      tkLString: aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).AsString);
      tkWString: aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).AsString);
      tkVariant: aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).ToString);
      tkArray: ;
      tkRecord: ;
      tkInterface: ;
      tkInt64: aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).AsInt64);
      tkDynArray: ;
      tkUString: aJSONObject.AddPair(PropertyName, RttiProperty.GetValue(Pointer(aObject)).AsString);
      tkClassRef: ;
      tkPointer: ;
      tkProcedure: ;
      tkMRecord: ;
    end;
  end;
end;

procedure TOrionReflections.ObjectToObject(aSource, aTarget: TObject);
var
  RttiContextSource : TRttiContext;
  RttiTypeSource : TRttiType;
  RttiPropertySource : TRttiProperty;
  RttiContextTarget : TRttiContext;
  RttiTypeTarget : TRttiType;
  RttiPropertyTarget : TRttiProperty;
  lObject: TObject;
begin
  RttiContextSource := TRttiContext.Create;
  RttiContextTarget := TRttiContext.Create;
  RttiTypeSource := RttiContextSource.GetType(aSource.ClassInfo);
  RttiTypeTarget := RttiContextTarget.GetType(aTarget.ClassInfo);
  for RttiPropertySource in RttiTypeSource.GetProperties do begin
    RttiPropertyTarget := RttiTypeTarget.GetProperty(RttiPropertySource.Name);
    if RttiPropertyTarget.PropertyType.TypeKind = tkClass then begin
      if RttiPropertyTarget.GetValue(Pointer(aTarget)).AsObject.ClassName.Contains('TObjectList<') then begin
        TObjectList<TObject>(RttiPropertySource.GetValue(Pointer(aSource)).AsObject).OwnsObjects := False;
        TObjectList<TObject>(RttiPropertyTarget.GetValue(Pointer(aTarget)).AsObject).Clear;
        for lObject in TObjectList<TObject>(RttiPropertySource.GetValue(Pointer(aSource)).AsObject) do begin
          TObjectList<TObject>(RttiPropertyTarget.GetValue(Pointer(aTarget)).AsObject).Add(lObject);
        end;
      end
      else begin
        ObjectToObject(RttiPropertySource.GetValue(Pointer(aSource)).AsObject, RttiPropertyTarget.GetValue(Pointer(aTarget)).AsObject);
      end;
      Continue;
    end;
    RttiPropertyTarget.SetValue(Pointer(aTarget), RttiPropertySource.GetValue(Pointer(aSource)));
  end;
end;

function TOrionReflections.StreamFromBase64(aStream: TStream): string;
var
  EncodedStream : TStringStream;
begin
  EncodedStream := TStringStream.Create;
  try
    TNetEncoding.Base64String.Encode(aStream, EncodedStream);
    Result := EncodedStream.DataString;
  finally
    FreeAndNil(EncodedStream);
  end;
end;

end.
