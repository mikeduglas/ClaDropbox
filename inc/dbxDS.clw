  MEMBER

  INCLUDE('svapi.inc'), ONCE

  MAP
    INCLUDE('svapifnc.inc'),ONCE
    MODULE('winapi')
      dbxds::OutputDebugString(*CSTRING lpOutputString),PASCAL,RAW,NAME('OutputDebugStringA')
      dbxds::SystemTimeToVariantTime(*_SYSTEMTIME SystemTime, *REAL pvtime),BOOL,RAW,PASCAL,NAME('SystemTimeToVariantTime')
      dbxds::VariantTimeToSystemTime(REAL vtime, *_SYSTEMTIME SystemTime),BOOL,RAW,PASCAL,NAME('VariantTimeToSystemTime')
      dbxds::VariantChangeType(*VARIANT vargDest,*VARIANT varSrc,USHORT wFlags = 0,SHORT vt),LONG,PASCAL,NAME('VariantChangeType')
    END

    dbxds::ClaDateTimeToVariant(<DATE dt>, <TIME tm>), VARIANT, PRIVATE
    dbxds::VariantToClaDate(VARIANT vtime, *DATE dt), PRIVATE
    dbxds::VariantToClaDateTime(VARIANT vtime, *DATE dt, *TIME tm), PRIVATE
  END

  INCLUDE('dbxDS.inc'), ONCE

!!!region static functions
dbxds::DebugInfo              PROCEDURE(STRING s)
pfx                             STRING('[DbxDS] ')
cs                              CSTRING(LEN(s) + LEN(pfx) + 1)
  CODE
  cs = pfx & s
  dbxds::OutputDebugString(cs)

dbxds::ClaDateTimeToVariant   PROCEDURE(<DATE dt>, <TIME tm>)
systm                           LIKE(_SYSTEMTIME)
BTime                           GROUP,OVER(tm)
HS                                BYTE
Sec                               BYTE
Min                               BYTE
Hour                              BYTE
                                END
rtime                           REAL, AUTO
vtime                           VARIANT
hr                              HRESULT, AUTO
  CODE
  IF NOT OMITTED(dt)
    systm.wYear = YEAR(dt)
    systm.wMonth = MONTH(dt)
    systm.wDay = DAY(dt)
  END
  IF NOT OMITTED(tm)
    systm.wHour = BTime.Hour
    systm.wMinute = BTime.Min
    systm.wSecond = BTime.Sec
  END
  
  IF dbxds::SystemTimeToVariantTime(systm, rtime)
    vtime = rtime
    hr = dbxds::VariantChangeType(vtime, vtime, , VT_DATE)
    IF hr <> S_OK
      dbxds::DebugInfo('VariantChangeType() failed, error '& hr)
    END
    
    RETURN vtime
  ELSE
    
  END
  
  dbxds::DebugInfo('SystemTimeToVariantTime() failed.')
  RETURN 0
  
dbxds::VariantToClaDate       PROCEDURE(VARIANT vtime, *DATE dt)
rtime                           REAL, AUTO
systm                           LIKE(_SYSTEMTIME)
CTime                           LONG, AUTO
  CODE
  dt = 0
  rtime = vtime
  IF dbxds::VariantTimeToSystemTime(rtime, systm)
    dt = DATE(systm.wMonth, systm.wDay, systm.wYear)
  END
  
dbxds::VariantToClaDateTime   PROCEDURE(VARIANT vtime, *DATE dt, *TIME tm)
rtime                           REAL, AUTO
systm                           LIKE(_SYSTEMTIME)
CTime                           LONG, AUTO
  CODE
  dt = 0
  tm = 0
  rtime = vtime
  IF dbxds::VariantTimeToSystemTime(rtime, systm)
    dt = DATE(systm.wMonth, systm.wDay, systm.wYear)
    
    CTime = systm.wHour * 60 * 6000 + systm.wMinute * 6000 + systm.wSecond * 100 + systm.wMilliseconds * 10
    IF CTime 
      CTime += 1
    END
    
    tm = CTime
  END
!!!endregion
  
!!!region CdbxDSManager
CdbxDSManager.List            PROCEDURE(*QUEUE pQ)
  CODE
  MESSAGE('TODO: CdbxDSManager.List')
  RETURN FALSE
  
CdbxDSManager.Delete          PROCEDURE(STRING dsid)
  CODE
  RETURN CHOOSE(PARENT.vDelete(CLIP(dsid)) = S_OK)
!!!endregion
  
!!!region CdbxDS
CdbxDS.Save                   PROCEDURE(STRING jsonfile)
  CODE
  RETURN CHOOSE(PARENT.vSave(CLIP(jsonfile)) = S_OK)
  
CdbxDS.Delete                 PROCEDURE()
  CODE
  RETURN CHOOSE(PARENT.vDelete() = S_OK)
  
CdbxDS.DatastoreId            PROCEDURE()
bID                             BSTRING
  CODE
  PARENT.vDatastoreId(bID)
  RETURN bID
  
CdbxDS.Manager                PROCEDURE()
lpMgr                           LONG, AUTO
Mgr                             &CdbxDSManager
  CODE
  IF PARENT.vManager(ADDRESS(lpMgr)) = S_OK
    Mgr &= NEW CdbxDSManager
    IF Mgr.Init(lpMgr) <> S_OK
      DISPOSE(Mgr)
      Mgr &= NULL
    END
  END
  
  RETURN Mgr
!!!endregion
  
!!!region CdbxTable
CdbxTable.Construct           PROCEDURE()
  CODE
  SELF.m_COMIniter &= NEW CCOMIniter
  PARENT.Init()
  
CdbxTable.Destruct            PROCEDURE()
  CODE
  PARENT.Destruct()
  DISPOSE(SELF.m_COMIniter)

CdbxTable.Initialize          PROCEDURE(STRING oauth_token,STRING dsid,STRING tableid,STRING uKey)
  CODE
  RETURN CHOOSE(PARENT.vInitialize(CLIP(oauth_token), CLIP(dsid), CLIP(tableid), CLIP(uKey)) = S_OK)
  
CdbxTable.SetField            PROCEDURE(STRING fieldname,*BYTE fieldvalue)
v                               VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)
  
CdbxTable.SetField                      PROCEDURE(STRING fieldname,*SHORT fieldvalue)
v                                         VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*USHORT fieldvalue)
v                               VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*DATE fieldvalue)
v                               VARIANT
  CODE
  v = dbxds::ClaDateTimeToVariant(fieldvalue)
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*TIME fieldvalue)
v                               VARIANT
  CODE
  v = dbxds::ClaDateTimeToVariant(, fieldvalue)
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*DATE datevalue,*TIME timevalue)
v                               VARIANT
  CODE
  v = dbxds::ClaDateTimeToVariant(datevalue, timevalue)
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*LONG fieldvalue)
v                               VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*ULONG fieldvalue)
v                               VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*SREAL fieldvalue)
v                               VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*REAL fieldvalue)
v                               VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*BFLOAT4 fieldvalue)
v                               VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,*BFLOAT8 fieldvalue)
v                               VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.SetField            PROCEDURE(STRING fieldname,? fieldvalue)
v                               VARIANT
  CODE
  v = fieldvalue
  RETURN CHOOSE(PARENT.vSetField(CLIP(fieldname), v) = S_OK)

CdbxTable.ClearRecord         PROCEDURE()
  CODE
  RETURN CHOOSE(PARENT.vClearRecord() = S_OK)
  
CdbxTable.Insert              PROCEDURE()
bRet                            VARIANT_BOOL, AUTO
  CODE
  SELF.WriteRecord()
  PARENT.vInsert(bRet)
  RETURN CHOOSE(bRet = VARIANT_TRUE)
    
CdbxTable.Update              PROCEDURE()
bRet                            VARIANT_BOOL, AUTO
  CODE
  SELF.WriteRecord()
  PARENT.vUpdate(bRet)
  RETURN CHOOSE(bRet = VARIANT_TRUE)
    
CdbxTable.Delete              PROCEDURE()
bRet                            VARIANT_BOOL, AUTO
  CODE
  SELF.WriteRecord()
  PARENT.vDelete(bRet)
  RETURN CHOOSE(bRet = VARIANT_TRUE)

CdbxTable.Select              PROCEDURE(STRING colname,? colvalue,STRING operation,BOOL ignoreCase)
v                               VARIANT
  CODE
  v = colvalue
  IF PARENT.vSelect(CLIP(colname), v, CLIP(operation), CHOOSE(ignoreCase = TRUE, VARIANT_TRUE, VARIANT_FALSE)) = S_OK
    LOOP WHILE SELF.Next()
    END
    
    RETURN TRUE
  END
  
  RETURN FALSE
  
CdbxTable.SelectAll           PROCEDURE()
v                               VARIANT
  CODE
  IF PARENT.vSelect('', v, '', VARIANT_FALSE) = S_OK
    LOOP WHILE SELF.Next()
    END
    
    RETURN TRUE
  END
  
  RETURN FALSE

CdbxTable.Count               PROCEDURE()
nCnt                            LONG, AUTO
  CODE
  PARENT.vCount(nCnt)
  RETURN nCnt
  
CdbxTable.Next                PROCEDURE()
bRet                            VARIANT_BOOL, AUTO
  CODE
  IF PARENT.vNext(bRet) = S_OK AND CHOOSE(bRet = VARIANT_TRUE)
    SELF.ReadRecord()
    RETURN TRUE
  END
  
  RETURN FALSE
  
CdbxTable.Previous            PROCEDURE()
bRet                            VARIANT_BOOL, AUTO
  CODE
  IF PARENT.vPrevious(bRet) = S_OK AND CHOOSE(bRet = VARIANT_TRUE)
    SELF.ReadRecord()
    RETURN TRUE
  END
  
  RETURN FALSE
  
CdbxTable.Reset               PROCEDURE()
  CODE
  RETURN CHOOSE(PARENT.vReset() = S_OK)

CdbxTable.GetField            PROCEDURE(STRING fieldname)
v                               VARIANT
gv                              LIKE(gVARIANT), OVER(v)
dt                              DATE, AUTO
  CODE
  PARENT.vGetField(CLIP(fieldname), v)
  
  IF gv.vt <> VT_DATE
    RETURN v
  END

  !-- fieldvalue is DateTime
  dbxds::VariantToClaDate(v, dt)
  RETURN dt
  
CdbxTable.GetField            PROCEDURE(STRING fieldname, *DATE datevalue, *TIME timevalue)
v                               VARIANT
gv                              LIKE(gVARIANT), OVER(v)
  CODE
  CLEAR(datevalue)
  CLEAR(timevalue)
  
  PARENT.vGetField(CLIP(fieldname), v)
  
  IF gv.vt <> VT_DATE
    dbxds::DebugInfo('CdbxTable.GetField: field '& CLIP(fieldname) &' not of DateTime type')
    RETURN
  END
  
  !-- fieldvalue is DateTime
  dbxds::VariantToClaDateTime(v, datevalue, timevalue)

CdbxTable.ReadRecord          PROCEDURE()
  CODE
  
CdbxTable.WriteRecord         PROCEDURE()
  CODE

CdbxTable.TableId             PROCEDURE()
bID                             BSTRING
  CODE
  PARENT.vTableId(bID)
  RETURN bID
  
CdbxTable.Datastore           PROCEDURE()
lpDS                            LONG, AUTO
ds                              &CdbxDS
  CODE
  IF PARENT.vDatastore(ADDRESS(lpDS)) = S_OK
    ds &= NEW CdbxDS
    IF ds.Init(lpDS) <> S_OK
      DISPOSE(ds)
      ds &= NULL
    END
  END
  
  RETURN ds
  
CdbxTable.Manager             PROCEDURE()
lpMgr                           LONG, AUTO
Mgr                             &CdbxDSManager
  CODE
  IF PARENT.vManager(ADDRESS(lpMgr)) = S_OK
    Mgr &= NEW CdbxDSManager
    IF Mgr.Init(lpMgr) <> S_OK
      DISPOSE(Mgr)
      Mgr &= NULL
    END
  END
  
  RETURN Mgr
  
!!!endregion CdbxTable