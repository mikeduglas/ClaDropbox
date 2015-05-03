!Generated .INC file (by the Easy COM generator v 1.14)

    INCLUDE('ecom2inc.def'),ONCE
    INCLUDE('ClaDropboxDS.int'),ONCE
    INCLUDE('ecombase.inc'),ONCE

IdbxDatastoreClass              CLASS(EasyCOMClass),TYPE,MODULE('ClaDropboxDS.clw'),LINK('ClaDropboxDS.clw')
IdbxDatastoreObj                  &IdbxDatastore,PROTECTED
Construct                         PROCEDURE()
Destruct                          PROCEDURE(),DERIVED
Init                              PROCEDURE(),HRESULT,PROC,DERIVED
Init                              PROCEDURE(LONG lpInterface),HRESULT,PROC,DERIVED
Kill                              PROCEDURE(),HRESULT,PROC,DERIVED
GetInterfaceObject                PROCEDURE(),*IdbxDatastore
GetInterfaceAddr                  PROCEDURE(),LONG
GetLibLocation                    PROCEDURE(),STRING,DERIVED
!Interface methods
vSave                             PROCEDURE(BSTRING par_file),HRESULT,PROC,VIRTUAL,PROTECTED
vDelete                           PROCEDURE(),HRESULT,PROC,VIRTUAL,PROTECTED
vDatastoreId                      PROCEDURE(*BSTRING pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vManager                          PROCEDURE(LONG pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
                                END

IdbxDatastoreManagerClass       CLASS(EasyCOMClass),TYPE,MODULE('ClaDropboxDS.clw'),LINK('ClaDropboxDS.clw')
IdbxDatastoreManagerObj           &IdbxDatastoreManager,PROTECTED
Construct                         PROCEDURE()
Destruct                          PROCEDURE(),DERIVED
Init                              PROCEDURE(),HRESULT,PROC,DERIVED
Init                              PROCEDURE(LONG lpInterface),HRESULT,PROC,DERIVED
Kill                              PROCEDURE(),HRESULT,PROC,DERIVED
GetInterfaceObject                PROCEDURE(),*IdbxDatastoreManager
GetInterfaceAddr                  PROCEDURE(),LONG
GetLibLocation                    PROCEDURE(),STRING,DERIVED
!Interface methods
vList                             PROCEDURE(*VARIANT pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vDelete                           PROCEDURE(BSTRING dsid),HRESULT,PROC,VIRTUAL,PROTECTED
                                END

IdbxTableClass                  CLASS(EasyCOMClass),TYPE,MODULE('ClaDropboxDS.clw'),LINK('ClaDropboxDS.clw')
IdbxTableObj                      &IdbxTable,PROTECTED
Construct                         PROCEDURE()
Destruct                          PROCEDURE(),DERIVED
Init                              PROCEDURE(),HRESULT,PROC,DERIVED
Init                              PROCEDURE(LONG lpInterface),HRESULT,PROC,DERIVED
Kill                              PROCEDURE(),HRESULT,PROC,DERIVED
GetInterfaceObject                PROCEDURE(),*IdbxTable
GetInterfaceAddr                  PROCEDURE(),LONG
GetLibLocation                    PROCEDURE(),STRING,DERIVED
!Interface methods
vInitialize                       PROCEDURE(BSTRING oauth_token,BSTRING dsid,BSTRING par_tableid,BSTRING uKey),HRESULT,PROC,VIRTUAL,PROTECTED
vSetField                         PROCEDURE(BSTRING fieldname,*VARIANT fieldvalue),HRESULT,PROC,VIRTUAL,PROTECTED
vClearRecord                      PROCEDURE(),HRESULT,PROC,VIRTUAL,PROTECTED
vInsert                           PROCEDURE(*VARIANT_BOOL pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vUpdate                           PROCEDURE(*VARIANT_BOOL pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vDelete                           PROCEDURE(*VARIANT_BOOL pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vSelect                           PROCEDURE(BSTRING colname,*VARIANT colvalue,BSTRING operation,VARIANT_BOOL ignoreCase),HRESULT,PROC,VIRTUAL,PROTECTED
vCount                            PROCEDURE(*LONG pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vNext                             PROCEDURE(*VARIANT_BOOL pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vPrevious                         PROCEDURE(*VARIANT_BOOL pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vReset                            PROCEDURE(),HRESULT,PROC,VIRTUAL,PROTECTED
vGetField                         PROCEDURE(BSTRING fieldname,*VARIANT pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vTableId                          PROCEDURE(*BSTRING pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vDatastore                        PROCEDURE(LONG pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
vManager                          PROCEDURE(LONG pRetVal),HRESULT,PROC,VIRTUAL,PROTECTED
                                END

