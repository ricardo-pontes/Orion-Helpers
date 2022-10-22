unit Orion.Helpers;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Rtti;

type
  TObjectHelper = class helper for TObject
  private
    procedure ObjectToObject(aSource, aTarget : TObject);
    procedure InternalClearObject(aObject: TObject);
  public
    procedure FromObject(aObject: TObject; aFreeAfterFinish : boolean = True);
    procedure ClearObject;
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

end.
