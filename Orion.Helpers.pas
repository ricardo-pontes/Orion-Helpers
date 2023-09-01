unit Orion.Helpers;
interface
uses
  System.SysUtils,
  System.Generics.Collections,
  System.Rtti,
  System.JSON,
  System.DateUtils,
  System.Classes,
  System.NetEncoding;
type
  TObjectHelper = class helper for TObject
  private
    function GetObjectInstance(aQualifiedClassName : string) : TObject; overload;
    procedure SetValueToObject(lProperty : TRttiProperty; aJson : TJSONObject);
    procedure SetValueToObjectList(aValue: string; aList : TObjectList<TObject>);
    procedure SetValueToJson(lProperty : TRttiProperty; var aJson : TJSONObject);
    procedure SetValueToJsonArray(aObjectList: TObjectList<TObject>; var aJson: TJSONArray);
    procedure GetPairValue(var lPairValue: TJSONValue; aJson: TJSONObject; lProperty: TRttiProperty);
    procedure ObjectToObject(aSource, aTarget : TObject);
    procedure InternalClearObject(aObject: TObject);
  public
    procedure FromObject(aObject: TObject; aFreeAfterFinish : boolean = True);
    procedure ClearObject;
    procedure FromJSON(aValue : string); overload;
    procedure FromJSON(aValue : TJSONObject); overload;
    procedure FromJSON(aValue : TJSONArray); overload;
    function ToJSONString(aPretty : boolean = false) : string;
    function ToJSONObject : TJSONObject;
    function ToJSONArray : TJSONArray;
  end;
implementation
{ TObjectHelper }
procedure TObjectHelper.ClearObject;
begin
  if not Assigned(Self) then
    Exit;
  if (Self.ClassName.Contains('TObjectList<')) then
    TObjectList<TObject>(Self).Clear
  else
    InternalClearObject(Self);
end;
procedure TObjectHelper.FromJSON(aValue: string);
var
  lJson : TJSONValue;
  lContext : TRttiContext;
  lType : TRttiType;
  lProperty: TRttiProperty;
begin
  lJson := TJSONValue.ParseJSONValue(aValue);
  lContext := TRttiContext.Create;
  lType := lContext.GetType(Self.ClassInfo);
  try
    if lJson is TJSONObject then begin
      for lProperty in lType.GetProperties do begin
        SetValueToObject(lProperty, TJSONObject(lJson));
      end;
    end
    else if lJson is TJSONArray then begin
      if Self.ClassName.Contains('TObjectList<') then begin
        TObjectList<TObject>(Self).Clear;
        SetValueToObjectList(lJson.ToJSON, TObjectList<TObject>(Self));
      end;
    end;
  finally
    FreeAndNil(lJson);
    FreeAndNil(lType);
  end;
end;
procedure TObjectHelper.FromJSON(aValue: TJSONObject);
var
  lContext : TRttiContext;
  lType : TRttiType;
  lProperty: TRttiProperty;
begin
  lContext := TRttiContext.Create;
  lType := lContext.GetType(Self.ClassInfo);
  try
    for lProperty in lType.GetProperties do begin
      SetValueToObject(lProperty, aValue);
    end;
  finally
    FreeAndNil(lType);
  end;
end;
procedure TObjectHelper.FromJSON(aValue: TJSONArray);
var
  lContext : TRttiContext;
  lType : TRttiType;
begin
  lContext := TRttiContext.Create;
  lType := lContext.GetType(Self.ClassInfo);
  try
    if Self.ClassName.Contains('TObjectList<') then begin
      TObjectList<TObject>(Self).Clear;
      SetValueToObjectList(aValue.ToJSON, TObjectList<TObject>(Self));
    end;
  finally
    FreeAndNil(lType);
  end;
end;
procedure TObjectHelper.FromObject(aObject: TObject; aFreeAfterFinish : boolean = True);
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
    aObject.DisposeOf;
end;

function TObjectHelper.GetObjectInstance(aQualifiedClassName: string): TObject;
var
  lContext : TRttiContext;
  lType : TRttiType;
  lMethodType : TRttiMethod;
  lMetaClass : TClass;
  Obj: TObject;
begin
  lContext.Free;
  lType       := nil;
  lContext    := TRttiContext.Create;
  lType       := lContext.FindType(aQualifiedClassName);
  lMetaClass  := nil;
  lMethodType := nil;
  if Assigned(lType) then begin
    for lMethodType in lType.GetMethods do begin
      if lMethodType.HasExtendedInfo and lMethodType.IsConstructor and (Length(lMethodType.GetParameters) = 0) then begin
        lMetaClass := lType.AsInstance.MetaclassType;
        Break;
      end;
    end;
  end;
  Result := nil;
//  Result := lMetaClass.NewInstance;
  Result := lMethodType.Invoke(lMetaClass, []).AsObject;
end;

procedure TObjectHelper.GetPairValue(var lPairValue: TJSONValue; aJson: TJSONObject; lProperty: TRttiProperty);
var
  lCamelCasePairName: string;
begin
  lPairValue := aJson.FindValue(lProperty.Name);
  if not Assigned(lPairValue) then
  begin
    lCamelCasePairName := LowerCase((lProperty.Name.Chars[0]));
    lCamelCasePairName := lCamelCasePairName + Copy(lProperty.Name, 1, lProperty.Name.Length - 1);
    lPairValue := aJson.FindValue(lCamelCasePairName);
  end;
end;
procedure TObjectHelper.InternalClearObject(aObject: TObject);
var
  RttiProperty: TRttiProperty;
  RttiType : TRttiType;
  RttiContext : TRttiContext;
begin
  RttiContext := TRttiContext.Create;
  RttiType := RttiContext.GetType(aObject.ClassInfo);
  try
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
  finally
    RttiType.DisposeOf;
  end;
end;
procedure TObjectHelper.ObjectToObject(aSource, aTarget: TObject);
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
  try
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
  finally
    RttiTypeSource.DisposeOf;
  end;
end;
procedure TObjectHelper.SetValueToJson(lProperty: TRttiProperty; var aJson: TJSONObject);
var
  lJsonArray : TJSONArray;
  StreamInput : TStream;
  StreamOutput : TStringStream;
begin
  case lProperty.PropertyType.TypeKind of
    tkUnknown: ;
    tkInteger: aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsInteger);
    tkChar: aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsString);
    tkEnumeration: aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsBoolean);
    tkFloat:
    begin
      if lProperty.PropertyType.QualifiedName.Contains('TDateTime') then
        aJson.AddPair(lProperty.Name, DateToISO8601(lProperty.GetValue(Pointer(Self)).AsExtended))
      else
        aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsExtended);
    end;
    tkString: aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsString);
    tkWChar: aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsString);
    tkLString: aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsString);
    tkWString: aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsString);
    tkInt64: aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsInt64);
    tkUString: aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsString);
    tkSet: ;
    tkClass: begin
      if lProperty.PropertyType.QualifiedName.Contains('TObjectList<') then begin
        lJsonArray := TJSONArray.Create;
        SetValueToJsonArray(TObjectList<TObject>(lProperty.GetValue(Pointer(Self)).AsObject), lJsonArray);
        aJson.AddPair(lProperty.Name, lJsonArray);
      end
      else if lProperty.GetValue(Pointer(Self)).AsObject.InheritsFrom(TStream) then begin
        StreamInput := lProperty.GetValue(Pointer(Self)).AsType<TStream>;
        StreamInput.Position := 0;
        StreamOutput := TStringStream.Create;
        try
          StreamOutput.LoadFromStream(StreamInput);
          aJson.AddPair(lProperty.Name, StreamOutput.DataString);
        finally
          StreamOutput.DisposeOf;
        end;
      end

      else begin
        aJson.AddPair(lProperty.Name, lProperty.GetValue(Pointer(Self)).AsObject.ToJSONObject);
      end;
    end;
    tkMethod: ;
    tkVariant: ;
    tkArray: ;
    tkRecord: ;
    tkInterface: ;
    tkDynArray: ;
    tkClassRef: ;
    tkPointer: ;
    tkProcedure: ;
    tkMRecord: ;
  end;
end;
procedure TObjectHelper.SetValueToJsonArray(aObjectList: TObjectList<TObject>; var aJson: TJSONArray);
var
  lJsonObject : TJSONObject;
  lObject : TObject;
begin
  for lObject in aObjectList do begin
    lJsonObject := lObject.ToJSONObject;
    aJson.Add(lJsonObject);
  end;
end;
procedure TObjectHelper.SetValueToObject(lProperty: TRttiProperty; aJson: TJSONObject);
var
  lPairValue : TJSONValue;
  Stream : TStringStream;
begin
  lPairValue := nil;
  GetPairValue(lPairValue, aJson, lProperty);
  if not Assigned(lPairValue) then
    Exit;
  if not lProperty.IsWritable then
    Exit;
  try
    case lProperty.PropertyType.TypeKind of
      tkInteger: lProperty.SetValue(Pointer(Self), lPairValue.Value.ToInteger);
      tkChar: lProperty.SetValue(Pointer(Self), lPairValue.Value);
      tkEnumeration: begin
        if lProperty.PropertyType.QualifiedName.Contains('Boolean') then
          lProperty.SetValue(Pointer(Self), lPairValue.Value.ToBoolean);
      end;
      tkFloat:
          begin
            if FormatSettings.CurrencyString = 'R$' then
              lProperty.SetValue(Pointer(Self), StrToFloat(lPairValue.Value.Replace('.', ',', [rfReplaceAll])))
            else
              lProperty.SetValue(Pointer(Self), StrToFloat(lPairValue.Value.Replace(',', '.', [rfReplaceAll])));
          end;
      end;
      tkString: lProperty.SetValue(Pointer(Self), lPairValue.Value);
      tkWChar: lProperty.SetValue(Pointer(Self), lPairValue.Value);
      tkLString: lProperty.SetValue(Pointer(Self), lPairValue.Value);
      tkWString: lProperty.SetValue(Pointer(Self), lPairValue.Value);
      tkInt64: lProperty.SetValue(Pointer(Self), lPairValue.Value.ToInt64);
      tkUString: lProperty.SetValue(Pointer(Self), lPairValue.Value);
      tkDynArray: ;
      tkUnknown: ;
      tkSet: ;
      tkClass:
      begin
        if lProperty.PropertyType.QualifiedName.Contains('TObjectList<') then begin
          TObjectList<TObject>(lProperty.GetValue(Pointer(Self)).AsObject).Clear;
          SetValueToObjectList(lPairValue.ToString, TObjectList<TObject>(lProperty.GetValue(Pointer(Self)).AsObject));
        end
        else if (lProperty.PropertyType.QualifiedName.Contains('Stream')) and not (lPairValue.Value.IsEmpty) then begin
          Stream := TStringStream.Create(lPairValue.Value);
          try
            if lProperty.GetValue(Pointer(Self)).AsObject is TStringStream then
              TStringStream(lProperty.GetValue(Pointer(Self)).AsObject).LoadFromStream(Stream)
            else if lProperty.GetValue(Pointer(Self)).AsObject is TMemoryStream then
              TMemoryStream(lProperty.GetValue(Pointer(Self)).AsObject).LoadFromStream(Stream);

            TStream(lProperty.GetValue(Pointer(Self)).AsObject).Position := 0;
          finally
            Stream.DisposeOf;
          end;
        end
        else if not (lPairValue.Value.IsEmpty) then
          lProperty.GetValue(Pointer(Self)).AsObject.FromJSON(lPairValue.ToString);
      end;
      tkMethod: ;
      tkVariant: ;
      tkArray: ;
      tkRecord: ;
      tkInterface: ;
      tkClassRef: ;
      tkPointer: ;
      tkProcedure: ;
      tkMRecord: ;
    end;
  finally
  end;
end;
procedure TObjectHelper.SetValueToObjectList(aValue: string; aList: TObjectList<TObject>);
var
  I: Integer;
  lObject: TObject;
  lJsonArray : TJSONArray;
  QualifiedClassName : string;
begin
  lJsonArray := TJSONArray.ParseJSONValue(aValue) as TJSONArray;
  if not Assigned(lJsonArray) then
    Exit;
  try
    QualifiedClassName := Copy(aList.QualifiedClassName, 41, aList.QualifiedClassName.Length-41);
    for I := 0 to Pred(lJsonArray.Count) do
    begin
      lObject := GetObjectInstance(QualifiedClassName);
      lObject.FromJSON(TJSONObject(lJsonArray.Items[i]));
      aList.Add(lObject);
    end;
  finally
    FreeAndNil(lJsonArray);
  end;
end;
function TObjectHelper.ToJSONArray: TJSONArray;
var
  lJsonArray : TJSONArray;
begin
  Result := nil;
  if not Self.QualifiedClassName.Contains('TObjectList<') then
    Exit;
  lJsonArray := TJSONArray.Create;
  SetValueToJsonArray(TObjectList<TObject>(Self), lJsonArray);
  Result := lJsonArray;
end;
function TObjectHelper.ToJSONObject: TJSONObject;
var
  lContext : TRttiContext;
  lType : TRttiType;
  lProperty : TRttiProperty;
begin
  lContext := TRttiContext.Create;
  lType := lContext.GetType(Self.ClassInfo);
  try
    Result := TJSONObject.Create;
    for lProperty in lType.GetProperties do begin
      SetValueToJson(lProperty, Result);
    end;
  finally
    FreeAndNil(lType);
  end;
end;
function TObjectHelper.ToJSONString(aPretty: boolean): string;
var
  lJson : TJSONObject;
  lJsonArray : TJSONArray;
begin
  if Self.QualifiedClassName.Contains('TObjectList<') then begin
    lJsonArray := TJSONArray.Create;
    try
      SetValueToJsonArray(TObjectList<TObject>(Self), lJsonArray);
      if aPretty then
        Result := lJsonArray.Format
      else
        Result := lJsonArray.ToJSON;
    finally
      FreeAndNil(lJsonArray);
    end;
  end
  else begin
    lJson := Self.ToJSONObject;
    try
      if aPretty then
        Result := lJson.Format
      else
        Result := lJson.ToJSON;
    finally
      FreeAndNil(lJson);
    end;
  end;
end;
end.
