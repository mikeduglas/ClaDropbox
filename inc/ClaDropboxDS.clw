!Generated .CLW file (by the Easy COM generator v 1.14)

  MEMBER
  INCLUDE('svcomdef.inc'),ONCE
  MAP
    MODULE('WinAPI')
      ecg_DispGetParam(LONG pdispparams,LONG dwPosition,VARTYPE vtTarg,*VARIANT pvarResult,*SIGNED uArgErr),HRESULT,RAW,PASCAL,NAME('DispGetParam')
      ecg_VariantInit(*VARIANT pvarg),HRESULT,PASCAL,PROC,NAME('VariantInit')
      ecg_VariantClear(*VARIANT pvarg),HRESULT,PASCAL,PROC,NAME('VariantClear')
      ecg_VariantCopy(*VARIANT vargDest,*VARIANT vargSrc),HRESULT,PASCAL,PROC,NAME('VariantCopy')
      memcpy(LONG lpDest,LONG lpSource,LONG nCount),LONG,PROC,NAME('_memcpy')
      GetErrorInfo(ULONG dwReserved,LONG pperrinfo),HRESULT,PASCAL,PROC
    END
    INCLUDE('svapifnc.inc')
    Dec2Hex(ULONG),STRING
    INCLUDE('getvartype.inc', 'DECLARATIONS')
  END
  INCLUDE('ClaDropboxDS.inc')

Dec2Hex                       PROCEDURE(ULONG pDec)
locHex                          STRING(30)
  CODE
  LOOP UNTIL(~pDec)
    locHex = SUB('0123456789ABCDEF',1+pDec % 16,1) & CLIP(locHex)
    pDec = INT(pDec / 16)
  END
  RETURN CLIP(locHex)

  INCLUDE('getvartype.inc', 'CODE')
!========================================================!
! IdbxDatastoreClass implementation                      !
!========================================================!
IdbxDatastoreClass.Construct  PROCEDURE()
  CODE
  SELF.debug=true

IdbxDatastoreClass.Destruct   PROCEDURE()
  CODE
  IF SELF.IsInitialized=true THEN SELF.Kill() END

IdbxDatastoreClass.Init       PROCEDURE()
loc:lpInterface                 LONG
  CODE
  SELF.HR=CoCreateInstance(ADDRESS(IID_dbxDatastore),0,SELF.dwClsContext,ADDRESS(IID_IdbxDatastore),loc:lpInterface)
  IF SELF.HR=S_OK
    RETURN SELF.Init(loc:lpInterface)
  ELSE
    SELF.IsInitialized=false
    SELF._ShowErrorMessage('IdbxDatastoreClass.Init: CoCreateInstance',SELF.HR)
  END
  RETURN SELF.HR

IdbxDatastoreClass.Init       PROCEDURE(LONG lpInterface)
  CODE
  IF PARENT.Init(lpInterface) = S_OK
    SELF.IdbxDatastoreObj &= (lpInterface)
  END
  RETURN SELF.HR

IdbxDatastoreClass.Kill       PROCEDURE()
  CODE
  IF PARENT.Kill() = S_OK
    SELF.IdbxDatastoreObj &= NULL
  END
  RETURN SELF.HR

IdbxDatastoreClass.GetInterfaceObject PROCEDURE()
  CODE
  RETURN SELF.IdbxDatastoreObj

IdbxDatastoreClass.GetInterfaceAddr   PROCEDURE()
  CODE
  RETURN ADDRESS(SELF.IdbxDatastoreObj)
  !RETURN INSTANCE(SELF.IdbxDatastoreObj, 0)

IdbxDatastoreClass.GetLibLocation PROCEDURE()
  CODE
  RETURN GETREG(REG_CLASSES_ROOT,'CLSID\{{2AA0E112-B28E-49AF-9D04-BC47BADCAD4B}\InprocServer32')

IdbxDatastoreClass.vSave      PROCEDURE(BSTRING ppar_file)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxDatastoreObj.Save(ppar_file)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxDatastoreClass.Save',HR)
  END
  RETURN HR

IdbxDatastoreClass.vDelete    PROCEDURE()
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxDatastoreObj.Delete()
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxDatastoreClass.Delete',HR)
  END
  RETURN HR

IdbxDatastoreClass.vDatastoreId   PROCEDURE(*BSTRING ppRetVal)
HR                                  HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxDatastoreObj.DatastoreId(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxDatastoreClass.DatastoreId',HR)
  END
  RETURN HR

IdbxDatastoreClass.vManager   PROCEDURE(LONG ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxDatastoreObj.Manager(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxDatastoreClass.Manager',HR)
  END
  RETURN HR

!========================================================!
! IdbxDatastoreManagerClass implementation               !
!========================================================!
IdbxDatastoreManagerClass.Construct   PROCEDURE()
  CODE
  SELF.debug=true

IdbxDatastoreManagerClass.Destruct    PROCEDURE()
  CODE
  IF SELF.IsInitialized=true THEN SELF.Kill() END

IdbxDatastoreManagerClass.Init    PROCEDURE()
loc:lpInterface                     LONG
  CODE
  SELF.HR=CoCreateInstance(ADDRESS(IID_dbxDatastoreManager),0,SELF.dwClsContext,ADDRESS(IID_IdbxDatastoreManager),loc:lpInterface)
  IF SELF.HR=S_OK
    RETURN SELF.Init(loc:lpInterface)
  ELSE
    SELF.IsInitialized=false
    SELF._ShowErrorMessage('IdbxDatastoreManagerClass.Init: CoCreateInstance',SELF.HR)
  END
  RETURN SELF.HR

IdbxDatastoreManagerClass.Init    PROCEDURE(LONG lpInterface)
  CODE
  IF PARENT.Init(lpInterface) = S_OK
    SELF.IdbxDatastoreManagerObj &= (lpInterface)
  END
  RETURN SELF.HR

IdbxDatastoreManagerClass.Kill    PROCEDURE()
  CODE
  IF PARENT.Kill() = S_OK
    SELF.IdbxDatastoreManagerObj &= NULL
  END
  RETURN SELF.HR

IdbxDatastoreManagerClass.GetInterfaceObject  PROCEDURE()
  CODE
  RETURN SELF.IdbxDatastoreManagerObj

IdbxDatastoreManagerClass.GetInterfaceAddr    PROCEDURE()
  CODE
  RETURN ADDRESS(SELF.IdbxDatastoreManagerObj)
  !RETURN INSTANCE(SELF.IdbxDatastoreManagerObj, 0)

IdbxDatastoreManagerClass.GetLibLocation  PROCEDURE()
  CODE
  RETURN GETREG(REG_CLASSES_ROOT,'CLSID\{{9321B1CC-C4AD-4D63-809A-580881BDD130}\InprocServer32')

IdbxDatastoreManagerClass.vList   PROCEDURE(*VARIANT ppRetVal)
HR                                  HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxDatastoreManagerObj.List(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxDatastoreManagerClass.List',HR)
  END
  RETURN HR

IdbxDatastoreManagerClass.vDelete PROCEDURE(BSTRING pdsid)
HR                                  HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxDatastoreManagerObj.Delete(pdsid)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxDatastoreManagerClass.Delete',HR)
  END
  RETURN HR

!========================================================!
! IdbxTableClass implementation                          !
!========================================================!
IdbxTableClass.Construct      PROCEDURE()
  CODE
  SELF.debug=true

IdbxTableClass.Destruct       PROCEDURE()
  CODE
  IF SELF.IsInitialized=true THEN SELF.Kill() END

IdbxTableClass.Init           PROCEDURE()
loc:lpInterface                 LONG
  CODE
  SELF.HR=CoCreateInstance(ADDRESS(IID_dbxTable),0,SELF.dwClsContext,ADDRESS(IID_IdbxTable),loc:lpInterface)
  IF SELF.HR=S_OK
    RETURN SELF.Init(loc:lpInterface)
  ELSE
    SELF.IsInitialized=false
    SELF._ShowErrorMessage('IdbxTableClass.Init: CoCreateInstance',SELF.HR)
  END
  RETURN SELF.HR

IdbxTableClass.Init           PROCEDURE(LONG lpInterface)
  CODE
  IF PARENT.Init(lpInterface) = S_OK
    SELF.IdbxTableObj &= (lpInterface)
  END
  RETURN SELF.HR

IdbxTableClass.Kill           PROCEDURE()
  CODE
  IF PARENT.Kill() = S_OK
    SELF.IdbxTableObj &= NULL
  END
  RETURN SELF.HR

IdbxTableClass.GetInterfaceObject PROCEDURE()
  CODE
  RETURN SELF.IdbxTableObj

IdbxTableClass.GetInterfaceAddr   PROCEDURE()
  CODE
  RETURN ADDRESS(SELF.IdbxTableObj)
  !RETURN INSTANCE(SELF.IdbxTableObj, 0)

IdbxTableClass.GetLibLocation PROCEDURE()
  CODE
  RETURN GETREG(REG_CLASSES_ROOT,'CLSID\{{5284B643-8CD2-4FF6-AAFD-1ED23AFCD52E}\InprocServer32')

IdbxTableClass.vInitialize    PROCEDURE(BSTRING poauth_token,BSTRING pdsid,BSTRING ppar_tableid,BSTRING puKey)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Initialize(poauth_token,pdsid,ppar_tableid,puKey)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Initialize',HR)
  END
  RETURN HR

IdbxTableClass.vSetField      PROCEDURE(BSTRING pfieldname,*VARIANT pfieldvalue)
v:pfieldvalue                   VARIANT
gv:pfieldvalue                  LIKE(gVariant),OVER(v:pfieldvalue)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  v:pfieldvalue=pfieldvalue
  HR=SELF.IdbxTableObj.SetField(pfieldname,v:pfieldvalue)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.SetField',HR)
  END
  RETURN HR

IdbxTableClass.vClearRecord   PROCEDURE()
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.ClearRecord()
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.ClearRecord',HR)
  END
  RETURN HR

IdbxTableClass.vInsert        PROCEDURE(*VARIANT_BOOL ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Insert(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Insert',HR)
  END
  RETURN HR

IdbxTableClass.vUpdate        PROCEDURE(*VARIANT_BOOL ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Update(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Update',HR)
  END
  RETURN HR

IdbxTableClass.vDelete        PROCEDURE(*VARIANT_BOOL ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Delete(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Delete',HR)
  END
  RETURN HR

IdbxTableClass.vSelect        PROCEDURE(BSTRING pcolname,*VARIANT pcolvalue,BSTRING poperation,VARIANT_BOOL pignoreCase)
v:pcolvalue                     VARIANT
gv:pcolvalue                    LIKE(gVariant),OVER(v:pcolvalue)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  v:pcolvalue=pcolvalue
  HR=SELF.IdbxTableObj.Select(pcolname,v:pcolvalue,poperation,pignoreCase)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Select',HR)
  END
  RETURN HR

IdbxTableClass.vCount         PROCEDURE(*LONG pRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Count(pRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Count',HR)
  END
  RETURN HR

IdbxTableClass.vNext          PROCEDURE(*VARIANT_BOOL ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Next(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Next',HR)
  END
  RETURN HR

IdbxTableClass.vPrevious      PROCEDURE(*VARIANT_BOOL ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Previous(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Previous',HR)
  END
  RETURN HR

IdbxTableClass.vReset         PROCEDURE()
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Reset()
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Reset',HR)
  END
  RETURN HR

IdbxTableClass.vGetField      PROCEDURE(BSTRING pfieldname,*VARIANT ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.GetField(pfieldname,ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.GetField',HR)
  END
  RETURN HR

IdbxTableClass.vTableId       PROCEDURE(*BSTRING ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.tableid(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.tableid',HR)
  END
  RETURN HR

IdbxTableClass.vDatastore     PROCEDURE(LONG ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Datastore(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Datastore',HR)
  END
  RETURN HR

IdbxTableClass.vManager       PROCEDURE(LONG ppRetVal)
HR                              HRESULT(S_OK)

  CODE
  IF SELF.IsInitialized=false THEN SELF.HR=E_FAIL;RETURN(SELF.HR) END
  HR=SELF.IdbxTableObj.Manager(ppRetVal)
  SELF.HR=HR
  IF HR < S_OK
    SELF._ShowErrorMessage('IdbxTableClass.Manager',HR)
  END
  RETURN HR

